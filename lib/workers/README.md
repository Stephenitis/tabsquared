How to upload the workers
sign up for an iron.io account and create a project

replace the iron-example.json with iron.json and the corresponding project_id and token

install the iron_worker_ng gem

    gem install iron_worker_ng

upload the worker, this is referring to the foursquare-api.worker file which defines what is uploaded to iron
    ironworker upload foursquare-api

get the webhook url
    iron_worker webhook foursquare
------> Creating client
        Project 'hackathon-stephentis' with id='0000000000000'
------> Generating code package webhook
        You can invoke your worker by POSTing to the following URL
        https://worker-aws-us-east-1.iron.io:443/2/projects/0000000000000/tasks/webhook?code_name=foursquare-api.&oauth=0000000000000-0000000000000

 place it in the environment WORKER_WEBHOOK_URL