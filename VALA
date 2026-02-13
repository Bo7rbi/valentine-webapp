from dataclasses import dataclass
from drafter import *



set_website_style("none")
set_website_framed(False)
hide_debug_information()

add_website_css("""
body {
    margin: 0;
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    font-family: 'Segoe UI', sans-serif;
    background: linear-gradient(135deg, #ff9a9e, #fad0c4);
}

.card {
    background: white;
    padding: 60px;
    border-radius: 20px;
    box-shadow: 0px 15px 40px rgba(0,0,0,0.2);
    text-align: center;
    width: 500px;
}

h1 {
    margin-bottom: 40px;
    font-weight: 600;
}

button {
    padding: 15px 35px;
    margin: 15px;
    border-radius: 30px;
    border: none;
    cursor: pointer;
    transition: all 0.3s ease;
    font-size: 18px;
}

.yes-btn {
    background-color: #ff4b91;
    color: white;
}

.no-btn {
    background-color: #444;
    color: white;
}

button:hover {
    transform: scale(1.1);
    box-shadow: 0px 5px 20px rgba(0,0,0,0.3);
}

.message {
    margin-top: 25px;
    color: #ff0055;
    font-weight: 500;
    font-size: 20px;
}
""")

@dataclass
class State:
    no_count: int


# ---------------- HOME PAGE ----------------

@route
def index(state: State) -> Page:

    yes_scale = 1 + (state.no_count * 0.35)
    no_scale = max(1 - (state.no_count * 0.25), 0.1)

    message = ""

    messages = [
        "why?",
        "Are you for real?",
        "u play tooooooo much!!",
        "you're getting me mad!!!!"
    ]

    if 1 <= state.no_count <= 4:
        message = messages[state.no_count - 1]

    if state.no_count >= 5:
        return Page(state, [
            '<div class="card">',
            "<h1>Ave Gower, would you be my valentine? 💘</h1>",
            Button("Yes", yes_page, style="font-size:22px;", classes="yes-btn"),
            Button("Yes", yes_page, style="font-size:22px;", classes="yes-btn"),
            '<div class="message">You don\'t have an option, I guesssssssssssssssssss :)</div>',
            "</div>"
        ])

    return Page(state, [
        '<div class="card">',
        "<h1>Ave Gower, would you be my valentine? 💘</h1>",

        Button("Yes", yes_page,
               style=f"transform: scale({yes_scale});",
               classes="yes-btn"),

        Button("No", no_pressed,
               style=f"transform: scale({no_scale});",
               classes="no-btn"),

        f'<div class="message">{message}</div>',
        "</div>"
    ])


# ---------------- YES PAGE ----------------

@route
def yes_page(state: State) -> Page:
    return Page(state, [
        '<div class="card">',
        "<h1>I'm happy that you said yes 💕</h1>",
        "Get ready on Saturday at 9 AM,",
        "and pack a small bag.",
        "</div>"
    ])


# ---------------- NO LOGIC ----------------

@route
def no_pressed(state: State) -> Page:
    state.no_count += 1
    return index(state)


start_server(State(0), host="0.0.0.0")

