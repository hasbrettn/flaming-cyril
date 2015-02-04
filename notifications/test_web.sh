#!/bin/bash

printf "\nCalling service to list all notifications...\n\n"
printf "Reponse: \n\n"
curl http://localhost:4567/notifications/find
printf "\n\n"

printf "\nCalling service to create a new notification...\n\n"
printf "Reponse: \n\n"
curl -H "Content-Type: application/json" -d '{"title":"blah","message":"blah","image_url":"http://coolurl.com/test.jpg","email_address":"fakeemail@hotmail.com"}' http://localhost:4567/notification/create
printf "\n\n"

printf "\nCalling service to verify creation...\n\n"
printf "Reponse: \n\n"
curl http://localhost:4567/notifications/find
printf "\n\n"

printf "\nCalling service to create a with a bad notification...\n\n"
printf "Reponse: \n\n"
curl -H "Content-Type: application/json" -d '{"title":"blah","message":"blah","email_address":"fakeemail@hotmail.com"}' http://localhost:4567/notification/create
printf "\n\n"

printf "\nCalling service to verify it did not create notification...\n\n"
printf "Reponse: \n\n"
curl http://localhost:4567/notifications/find
printf "\n\n"