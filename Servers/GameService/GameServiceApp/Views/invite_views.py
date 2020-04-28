from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

from GameServiceApp.active_player_list import token_status
from GameServiceApp.helper_methods import get_json_data_object, connection_service


# INVITES #
# POST = Invite player. GET = get all invites
@api_view(['POST', 'GET'])
def invites(request):
    invite_response = ""
    # Check if the request body has the proper json format
    req_json = get_json_data_object(request,
                                    "There is an error in your body json format. It should be ex {'user_token':'your_user_token','sender_player_id':38,'reciever_player_id':39,'match_name':'TestMatch','question_duration':5}")
    if type(req_json) == Response:
        return req_json

    # If token is present in the list do the following
    if token_status(req_json['user_token']):
        if request.method == 'POST':
            # Getting relevant data from the request to use later
            sender_player_id = req_json['sender_player_id']
            receiver_player_id = req_json['receiver_player_id']
            match_name = req_json['match_name']
            question_duration = req_json['question_duration']

            # Check if the invited player already exists in DB
            try:
                response = connection_service("/players/" + str(receiver_player_id) + "/", None, "GET")
            except:
                return Response("The player you want to invite does not exist anymore",
                                status=status.HTTP_204_NO_CONTENT)
            # End Check

            # Setting parameters and getting the response
            form_param = {
                "invite": {"sender_player_id": str(sender_player_id), "receiver_player_id": str(receiver_player_id),
                           "match_name": match_name, "question_duration": str(question_duration), "accepted": False}}
            response = connection_service("/invites/", form_param, "POST")

            # Getting data for  the invite_response var
            invite_object = response['invite']
            receiver_player = invite_object['receiver_player']

            invite_response = "Player " + receiver_player['first_name'] + " " + receiver_player[
                'last_name'] + " has been invited to play"

        if request.method == 'GET':
            form_param = {"player_id": req_json['player_id']}
            invite_response = connection_service("/invites/", form_param, "GET")
        return Response(data=invite_response, status =status.HTTP_200_OK)
    else:
        return Response(data = "Token not valid. Please login again", status=status.HTTP_401_UNAUTHORIZED)



# Accept invitation
@api_view(['PUT'])
def accept_invite(request, invite_id):
    # Check if the request body has the proper json format
    req_json = get_json_data_object(request,
                                    "There is an error in your body json format. It should be ex {'user_token':'your_user_token'}")
    if type(req_json) == Response:
        return Response(req_json)

    # If token is present in the list do the following
    if token_status(req_json['user_token']):
        # Create the json package for the request

        invite_data = {"invite": {"accepted":True}}
        response = connection_service("/invites/" + invite_id + "/", invite_data, "PUT")
        return Response(data="Invitation Accepted", status=status.HTTP_200_OK)
    else:
        return Response("Token not valid. Please login again", status=status.HTTP_401_UNAUTHORIZED)
