from django.http import HttpResponse


# Create your views here.
def nothing(request):
    return HttpResponse(
        "Hello, user. You're at the root index of the Gameserver Here we could have the entire REST tree printed")
