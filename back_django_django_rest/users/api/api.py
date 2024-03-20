from users.services import AuthService
from rest_framework.response import Response
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import AllowAny
from rest_framework.views import APIView
from rest_framework.request import Request
from rest_framework import permissions
from rest_framework import status


class LoginView(APIView):
    permission_classes = [permissions.AllowAny]

    def post(self, request: Request, *args, **kwargs):
        data = request.data
        username = data.get("username", "")
        password = data.get("password", "")
        print(f"{username} - {password}")
        user = AuthService.authenticate(username, password)
        if user:
            refres = RefreshToken.for_user(user)
            token_data = {
                "access_token": str(refres.access_token),
                "id_user": str(user.pk)
            }
            return Response(data=token_data, status=200)
        error_data = {"message": "Usuario o contraseña incorrectos"}
        return Response(data=error_data, status=400)
    

class UpdateTokenView(APIView):
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]

    def post(self, request, *args, **kwargs):
        user = request.user
        token = request.data.get("token", None)
        
        if token is not None:
            user.hash_notification = token
            user.save()
            
            return Response({"message": "Token actualizado correctamente"}, status=status.HTTP_200_OK)
        else:
            return Response({"error": "No se proporcionó un token"}, status=status.HTTP_400_BAD_REQUEST)


