CORRECT_GAME_JSON = {
    'game':
        {
            "match_name": "Example name",
            "question_duration": 20.0,
            "questions":
                [
                    1,
                    2,
                    3
                ],
            "player_status":
                [
                    {
                        "game_player":
                            {
                                "player_id": 1,
                                "game_progress": 20,
                                "score": 10
                            },
                        "game_round":
                            [
                                {
                                    "time_spent": 20.0,
                                    "score": 10
                                },
                                {
                                    "time_spent": 34.0,
                                    "score": 345
                                }
                            ]
                    },
                    {
                        "game_player":
                            {
                                "player_id": 2,
                                "game_progress": 20,
                                "score": 10
                            },
                        "game_round":
                            [
                                {
                                    "time_spent": 20.0,
                                    "score": 10
                                },
                                {
                                    "time_spent": 34.0,
                                    "score": 345
                                }
                            ]
                    }
                ]

        }
}

CORRECT_PLAYER_STATUS_JSON = {
    "game_player":
        {
            "game_progress": 20,
            "score": 10
        },
    "game_round":
        [
            {
                "time_spent": 20.0,
                "score": 10
            },
            {
                "time_spent": 34.0,
                "score": 345
            }
        ]
}

CORRECT_PLAYER_JSON = {
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

CORRECT_QUESTION_JSON = {
    'question':
        {
            'question_text': 'What is the best programming language?',
            'correct_answer': 1,
            'answer_1': 'Python',
            'answer_2': 'Java',
            'answer_3': 'C#',
        }
}

CORRECT_INVITE_JSON = {
    "invite":
        {
            "sender_player_id": 1,
            "receiver_player_id": 1,
            "match_name": "Example match",
            "question_duration": 15,
            "accepted": False
        }
}