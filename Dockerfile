ARG EL=7
ARG VERSION

FROM htcondor/base:${VERSION}-el${EL}

ARG BUILDDATE
ARG EL=7
ARG VERSION
ARG OSG=3.5

LABEL org.label-schema.name="chtc/flock-negotiator:${VERSION}-el${EL}" \
      org.label-schema.description="HTCondor ${VERSION} negotiator image for OSG's pool"

RUN yum install -y /usr/bin/git cronie  &&  yum clean all && rm -rf /var/cache/yum/*
RUN \
    yum install -y https://repo.opensciencegrid.org/osg/${OSG}/osg-${OSG}-el${EL}-release-latest.rpm  && \
    yum-config-manager --setopt=osg.includepkgs=osg-ca-certs --save >/dev/null  && \
    yum install -y osg-ca-certs && \
    yum clean all && rm -rf /var/cache/yum/*  && \
:

RUN \
    git clone https://github.com/opensciencegrid/osg-flock.git /tmp/osg-flock  && \
    mv /tmp/osg-flock/flock.opensciencegrid.org/htcondor/config.d/*  /etc/condor/config.d/  && \
    # ^^ do we need _all_ the config? or just the negotiator stuff?
    rm -rf /tmp/osg-flock  && \
:

COPY container-files /

LABEL org.label-schema.build-date="${BUILDDATE}"

# vim:et:sw=4:sts=4:ts=8
