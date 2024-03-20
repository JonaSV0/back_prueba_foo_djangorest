from users.models import User


class AuthService:
    @staticmethod
    def authenticate(username, password) -> User | None:
        user = User.objects.filter(username=username).first()
        if user and user.check_password(password):
            return user
        return None
