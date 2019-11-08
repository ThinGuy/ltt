FROM ubuntu:18.04

ENV container docker
ENV DEBIAN_FRONTEND=noninteractive
RUN apt 2>/dev/null -qq update && \
	apt 2>/dev/null -yqq dist-upgrade && \
	apt 2>/dev/null install -yqq figlet

ENTRYPOINT figlet "Hello World"
