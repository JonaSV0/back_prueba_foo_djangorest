
from users.models import User
from django.db.models import Q
import requests

class NotificationService:
    def send_notification(title, message):
        #print("Sending messages")
        list_person = User.objects.all()

        list_notifications = []
        for person in list_person:
            print(person.username)
            if person.hash_notification is not None:
                list_notifications.append(person.hash_notification)

        for token_user in list_notifications:

            headers = {
                "Authorization": "key=AAAA7SaCPKI:APA91bGlM0yadfUeG6w45pI3BA-PjJMGb-4i6NUjYNq9HJJTo_KSpmsUaTBb5J4TS3yEvveS_6txOB8Re9ITlINwEm7Kc5hvC0O7JCv3CKU9KuVv8F44bihPr6lSv3kzRoTV5PwsYYVC",
                "Content-Type": "application/json"
            }

            json = {
                "to": token_user,
                "notification": {
                    "title": title,
                    "body": message,
                },
                "data" : {
                    "message" : "NOT"
                },
                "android": {
                    "priority": "high"
                },
                "priority": 10
            }
            #print(json)
            res = requests.post('https://fcm.googleapis.com/fcm/send', json=json, headers=headers)
            #print('this is the true http resonse: ',res.status_code)
            # if res.status_code==200:
            #     print("Success")
            # else:
            #     print("Error: ",res.status_code)
