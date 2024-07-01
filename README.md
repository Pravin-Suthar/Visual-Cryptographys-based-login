

Disclaimer

The source code contained in this repository is the intellectual property of Pravin Suthar. Pravin Suthar is the original author and copyright holder of the code. By accessing this repository, you are granted a non-exclusive, worldwide, royalty-free license to use, modify, and distribute the code for personal and commercial purposes, provided that proper attribution is given to the original author. This license does not grant you any rights to use the author's name, logo, or trademarks without prior written consent.

The code is provided "as-is," without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose, and non-infringement. In no event shall the author be liable for any claim, damages, or other liability, whether in an action of contract, tort, or otherwise, arising from, out of, or in connection with the code or the use or other dealings in the code.




THE MAIN OBJECTIVE OF THE PROJECT:
The primary objective of this project is to develop a highly secure authentication system that mitigates the risk of middleman attacks during OTP transmission. By employing Visual Cryptography, the OTP is embedded into a canvas and split into two images. These images are then distributed separately: one via an encrypted HTTP transmission and the other via SMTP email. The OTP is revealed only when the user correctly overlaps the two images, ensuring that a single image cannot compromise the security of the OTP.

This approach leverages Affine Algorithms and Steganography to enhance security and reliability. By addressing the vulnerabilities of traditional OTP systems, this project aims to provide a robust solution for secure user authentication in the digital age. This need is further underscored by the recent recommendations from platforms like GitHub and the development of dedicated authenticator apps by companies such as Microsoft, highlighting the inadequacy of conventional OTP methods.


Data Flow:

                +---------------------+
                |  User Requests Login |
                +----------+----------+
                           |
                           v
                +----------+----------+
                | Backend Processes   |
                |       Request       |
                +----------+----------+
                           |
                           v
                +----------+----------+
                | Generate OTP        |
                +----------+----------+
                           |
                           v
                +----------+----------+
                | Embed OTP in Canvas |
                +----------+----------+
                           |
                           v
          +----------------+-----------------+
          |                                  |
          v                                  v
 +--------+---------+              +---------+--------+
 | Split OTP into   |              | Split OTP into   |
 | Image OTP1       |              | Image OTP2       |
 +--------+---------+              +---------+--------+
          |                                  |
          v                                  v
 +--------+---------+              +---------+--------+
 | Encrypt & Send   |              | Send OTP2 via    |
 | OTP1 via HTTP    |              | Email (SMTP)     |
 +--------+---------+              +---------+--------+
          |                                  |
          v                                  v
 +--------+---------+              +---------+--------+
 | Frontend Receives |              | User Receives    |
 | OTP1              |              | OTP2             |
 +--------+---------+              +---------+--------+
          |                                  |
          v                                  v
 +--------+---------+              +---------+--------+
 | User Uploads OTP2|              | Frontend Overlaps |
 +--------+---------+              | OTP1 & OTP2       |
          |                                  |
          v                                  v
 +--------+---------+              +---------+--------+
 | Reveal OTP       |              | User Enters OTP  |
 +--------+---------+              +---------+--------+
          |                                  |
          v                                  v
 +--------+---------+              +---------+--------+
 | Entered OTP Sent |              | Backend Matches  |
 | to Backend       |              | OTP              |
 +--------+---------+              +---------+--------+
          |                                  |
          v                                  v
 +--------+---------+              +---------+--------+
 | Successful       |              | Authentication   |
 | Authentication   |              | if OTPs Match    |
 +------------------+              +------------------+


Hey if you have read so far that means the topic has exited you and i believe you should give it a try by running locally. I am writing instruction in the most simple language possible if having any issues running this the please raise a PR. 


The main repository contains two folders:

Backend: Contains the Visual-crpyto-auth-backend code.
Frontend: Contains the Visual-crpyto-auth-frontend code.


Starting Backend:
1. Navigate to the backend folder: cd Visual-crpyto-auth-backend.
2. Inside the backend folder, locate the config folder which contains the middleware for the database connection.
3. Adjust the credentials in the .env file according to your local MySQL database
4. Here i have assumed you have a MYSQL server running locally and hence the first step will be create a database with name defined in the env of change the name in the env to one which you already have.
5. To make life easier i am letting the smtp credential be in this email as the account is a dummy account.
6. Run the backend server by typing npm run server in the terminal.
7. The server should now be running. Node.js version used: v20.11.0.



Starting Frontend:

1. Ensure you have Flutter installed, version details:
2. Version : Flutter 3.16.6  • Dart 3.2.3 • DevTools 2.28.4
3. Resolve all dependencies by running flutter pub get.
4. Connect a physical Android device with USB debugging enabled, or set up an Android emulator.
5. Navigate to the hamburger section in VS Code and go to Run -> Run without debugging, or type flutter run in the terminal.



Functionalities Added:


Backend:
1. Complete MVC structured backend.
2. Utilizes MySQL database.
3. Middleware layer for database connectivity.
4. User registration and login based on random OTP.
5. GET API to fetch user name and display it on the frontend homepage.
6. Sequelize and Express are used for ensuring database integrity.



Frontend:
1. State management using GetX.
2. Utilizes both stateless and stateful widgets.
3. Implements Firebase Analytics for insights into the app's usage.
4. Initial plan to display Firebase Analytics specific to the user, but direct API access isn't available.
5. Uses the https package for making requests.
6. Implements a common color palette file for centralized theming.
7. Implements common Snackbar and TextStyle files for consistency.
8. Implements a robust drawer on the landing page, along with tab navigation for the homepage (may have minor layout issues to resolve).


