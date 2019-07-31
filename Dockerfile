# docker run -it -p 15151:15151 -v /var/snap/lxd/common/lxd/unix.socket:/var/snap/lxd/common/lxd/unix.socket lxdui

FROM ubuntu:18.04 as BUILDER

RUN mkdir install
WORKDIR /install

RUN apt update && apt install -y python3 git

RUN apt install -y python3-pip
RUN pip3 install setuptools
RUN git clone https://github.com/AdaptiveScale/lxdui.git /app
RUN pip3 install --install-option="--prefix=/install" -r /app/requirements.txt
#RUN python3 setup.py install

FROM ubuntu:18.04
RUN apt-get update \
 && apt-get install -y lxd-client python3 python3-pkg-resources \
 && apt-get clean -y \
 && rm -rf /tmp/* /var/lib/apt/lists/*

COPY --from=BUILDER /install /usr
COPY --from=BUILDER /app/run.py /app/run.py
COPY --from=BUILDER /app/app /app/app
COPY --from=BUILDER /app/conf /app/conf
COPY --from=BUILDER /app/logs /app/logs

WORKDIR /app

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
EXPOSE 15151

ENTRYPOINT ["python3", "run.py", "start"]
