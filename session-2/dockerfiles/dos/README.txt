#Build Docker Container
docker build -t dos:latest .

# Run Docker Container
docker run -it --rm --name dos --env GREETING=Hi --env NAME=Craig --env TCOLS=$(tput cols) dos:latest
