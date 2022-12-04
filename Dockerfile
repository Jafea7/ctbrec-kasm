FROM kasmweb/core-ubuntu-bionic:1.11.0
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

# Copy default settings used for CTBRec
COPY default/ $HOME/ctbrec/

# Install mpv, Falkon, curl, change background, add Desktop icon
RUN apt-get update \
    && apt-get install -y --no-install-recommends mpv qupzilla curl \
    && rm -rf /var/lib/apt/lists/* \
    && cp $HOME/ctbrec/splash.png /usr/share/extra/backgrounds/bg_default.png \
    && cp -p $HOME/ctbrec/ctbrec.desktop /$HOME/Desktop/ \
    && chmod +x $HOME/Desktop/ctbrec.desktop \
    && chown 1000:1000 $HOME/Desktop/ctbrec.desktop

# Start CTBRec when container starts
RUN echo "/usr/bin/desktop_ready && cd /home/kasm-user/ctbrec && ./ctbrec.sh &" > $STARTUPDIR/custom_startup.sh \
    && chmod +x $STARTUPDIR/custom_startup.sh

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

######### CTBRec insertion #########
COPY --chown=1000:0 app/ $HOME/
######### END CTBRec insertion #########

USER 1000
