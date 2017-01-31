################################################################################
# Model:  <%= class_name %>
#
# Purpose:
#
# <%= class_name %> attributes:
<%- attributes.each do |attribute| -%>
<%- if attribute.name == 'name' -%>
#   name              - name:           string,  not NULL, unique
<%- elsif attribute.name == 'title' -%>
#   title             - title:          string,  not NULL
<%- elsif attribute.name == 'last_name' -%>
#   last_name         - last_name:      string,  not NULL
<%- elsif attribute.name == 'first_name:' -%>
#   first_name        - first_name:     string,  not NULL
<%- elsif attribute.name == 'email'-%>
#   email             - email:          string,  not NULL, unique
<%- elsif attribute.name == 'position' -%>
#   position          - sorting index:  integer, not NULL
<%- elsif attribute.name == 'role' -%>
#   role              - role:           enum
<%- elsif attribute.name == 'password_digest' -%>
#   password_digest   - password:       string, not NULL
<%- elsif attribute.name == 'remember_digest' -%>
#   remember_token    - remember token: string
<%- elsif attribute.name == 'status' -%>
#   status            - status:         enum { active (0) | archived (1) }
<%- else -%>
<%- if attribute.reference? -%>
#   <%= attribute.name %>_id          - FK
<%- else -%>
#   <%= attribute.name %>             - <%= attribute.name %>:  <%= attribute.type %>
<%- end -%>
<%- end -%>
<%- end -%>
#
#  <%= Date.today.strftime("%d.%m.%Y") %> ZT
################################################################################
<%- module_namespacing do -%>
class <%= class_name %> < <%= parent_class_name.classify %>
<%- attributes.select(&:reference?).each do |attribute| -%>
<%- if attribute.name == 'parent' -%>
  has_many   :children, class_name: <%= class_name %>, foreign_key: "parent_id"
  belongs_to :parent,   class_name: <%= class_name %>
<%- else -%>
  belongs_to :<%= attribute.name %><%= ', polymorphic: true' if attribute.polymorphic? %><%= ', required: true' if attribute.required? %>
<%- end -%>
<%- end -%>
<%- for attribute in attributes -%>
<%- if attribute.name == 'position' -%>

  before_save :set_position
<%- end -%>
<%- end -%>
<%- if class_name == 'User' -%>
<%- attributes.each do |attribute| -%>
<%- if attribute.name == 'email' -%>
  before_save {self.email.downcase!}
<%- end -%>
<%- end -%>
<%- attributes.each do |attribute| -%>
<%- if attribute.name == 'remember_token' -%>
  before_save :create_remember_token

  attr_accessor :remember_token
<%- end -%>
<%- end -%>
<%- end -%>

<%- attributes.each do |attribute| -%>
<%- if attribute.name == 'status' -%>
  enum status: %w(active archived)
<%- elsif attribute.name == 'role' -%>
  enum role:   %w(manager admin sysadmin)
<%- end -%>
<%- end -%>
<%- for attribute in attributes -%>
  <%- if attribute.name == 'parent' -%>

  scope :top_level, ->(){ where parent_id: nil }

  <%- end -%>
<%- end -%>

<%- attributes.select(&:reference?).each do |attribute| -%>
  validates :<%= attribute.name %>, presence: true
<%- end -%>

<%- if class_name == 'User' -%>
<%- for attribute in attributes -%>
<%- if attribute.name == 'email' -%>
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

<%- elsif attribute.name == 'last_name' -%>
  validates :last_name,  presence: true
<%- elsif attribute.name == 'first_name' -%>
  validates :first_name, presence: true

<%- elsif attribute.name == 'password_digest' -%>
  has_secure_password                      # validates presence of password & password_confirmation
  validates :password, length: {minimum: 8}
<%- end -%>
<%- end -%>
<%- end -%>

<%- attributes.each do |attribute| -%>
<%- if attribute.name == 'name' -%>
  validates :name,  presence: true, uniqueness: true
<%- elsif attribute.name == 'title' -%>
  validates :title, presence: true
<%- end -%>
<%- end -%>
<%- end -%>

<%- if class_name == 'User' -%>
  # Returns an User full name
  def full_name
    "#{last_name} #{first_name}"
  end

  private

    # Returns a random token
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    # Returns a random token.
    def User.new_token
      SecureRandom.urlsafe_base64
    end

    # Remembers a user in the database to apply him/her in persistent sessions
    def remember
      self.remember_token = User.new_token
      update_attribute(:remember_digest, User.digest(remember_token))
    end

    # Returns true if the given token matches the digest.
    def authenticated?(remember_token)
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
<%- else -%>
<%- for attribute in attributes -%>
<%- if attribute.name == 'position' -%>

  private

    def set_position
      if self.id.blank?
        last_item = <%= class_name %>.order(:position).last
        self.position = last_item.blank? ? 1 : last_item.position.to_i + 1
      end
    end
<%- end -%>
<%- end -%>
<%- end -%>
end
