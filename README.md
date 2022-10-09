# Speech to text

An application which recognizes voice inputs from user and converts into text

This is a 1 to 1 chat application with voice recognition and gets connected to a random person who is already registered. 
User have to auhtenticate with their google account for loggin into the app.
User will get their chat history back when they meet next time.
User will have to wait and get response from the other before sending the next message.

In the Homescreen I have added a big green button . On pressing the button user will navigate to a chatscreen by connecting to a random person who is already registered with the application. If there is other user is registered app will show a notification "No users found".

State management used : GetX with GetCLI.

packages used :

  speech_to_text: ^6.0.0
  avatar_glow: ^2.0.2
  firebase_core: ^1.24.0
  firebase_database: ^9.1.6
  firebase_auth: ^3.11.1
  cloud_firestore: ^3.5.0
  google_sign_in: ^5.4.2
  chat_bubbles: ^1.3.1
  connectivity_plus: ^2.3.9
  cached_network_image: ^3.2.2
  get: 4.6.5