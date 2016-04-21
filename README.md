To build

time docker build -t taf7lwappqystqp4u7wjsqkdc7dquw/sleepyepsilon .

To run

docker run -it --volume ${PWD}/private:/home/emory/private:ro --volume ${PWD}/report:/home/emory/report:rw taf7lwappqystqp4u7wjsqkdc7dquw/sleepyepsilon