This is a bootstrap application to do user signup with geo location with map.

Steps to execute this sample application:
=========================================

cd geo-mapper/
bundle install
bundle exec rails s
guard #start this in new terminal to monitor test cases


Then open your browser with the localhost and port number started by default: http://localhost:3000 by thin server.

Navigate to http://localhost:3000/signup for new user signup.

After user successfully signed up, page will be redirected to render google maps with the user's location eg: http://localhost:3000/users/1/show_map. To be notice here the marker will popups the user information and the google maps style will get change as per the user's current time.

Additional Features:
====================

User Information can be updatable except email(for security and uniqueness) on the edit page eg: http://localhost:3000/users/1/edit.