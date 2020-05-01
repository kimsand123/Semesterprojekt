CORRECT_GAME_OBJ = {
    "game": {
        "match_name": "MATCH_NAME",
        "question_duration": 20.0,
        "questions": [
            1,
            2,
            3
        ],
        "player_status": [
            {
                "game_player": {
                    "player_id": 3,
                    "game_progress": 5,
                    "score": 6
                },
                "game_round": [
                    {
                        "time_spent": 1.0,
                        "score": 2
                    },
                    {
                        "time_spent": 2.0,
                        "score": 4
                    }
                ]
            },
            {
                "game_player": {
                    "player_id": 1,
                    "game_progress": 6,
                    "score": 4
                },
                "game_round": [
                    {
                        "time_spent": 1.0,
                        "score": 2
                    },
                    {
                        "time_spent": 1.0,
                        "score": 2
                    }
                ]
            }
        ]
    }
}

CORRECT_PLAYER_OBJ = {
    'player':
        {
            'username': 's123456',
            'email': 's123456@student.dtu.dk',
            'first_name': 'Søren',
            'last_name': 'Træsko',
            'study_programme': 'Software technology',
            'high_score': 20.1,
        }
}


CORRECT_INVITE_OBJ = {
    "invite":
        {
            "sender_player_id": 1,
            "receiver_player_id": 1,
            "match_name": "Example match",
            "question_duration": 15,
            "accepted": False
        }
}