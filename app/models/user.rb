class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates :email, length: { maximum: 25 }, presence: true

  has_many :goals,
    inverse_of: :user,
    dependent: :destroy

  has_many :checkpoints,
    through: :goals

  def show
    @user = User.find(params[:id])
  end
end
