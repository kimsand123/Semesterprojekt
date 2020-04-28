export const api_players = "http://127.0.0.1:8000/players/"
export const api_games = "http://127.0.0.1:8000/games/"
export const api_questions = "http://127.0.0.1:8000/questions/"
export const api_invites = "http://127.0.0.1:8000/invites/"

const token = "5AF4813A4FCE13A2D5436A3E33BAA"
export const auth_header = {
    headers: { "Authorization": "Bearer " + token }
}