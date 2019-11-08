#Build Docker Container
docker build -t helloworld .

# Run Docker Container
docker run -it --name basic --rm --env GREETING=Hi --env NAME=Craig --env TCOLS=$(tput cols) helloworld
