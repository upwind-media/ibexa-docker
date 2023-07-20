#!/usr/bin/env bash

# Check if missing template folder
DESTINATION_IBEXA="/ibexasolr/server/ibexa"
DESTINATION_TEMPLATE="$DESTINATION_IBEXA/template"
if [ ! -d ${DESTINATION_TEMPLATE} ]; then
    cd $PROJECTMAPPINGFOLDER/ibexa
    mkdir -p $DESTINATION_TEMPLATE
    cp -R vendor/ibexa/solr/src/lib/Resources/config/solr/* $DESTINATION_TEMPLATE
fi

mkdir -p /ibexasolr/server/ibexa
if [ ! -f /ibexasolr/server/ibexa/solr.xml ]; then
    cp /opt/solr/server/solr/solr.xml /ibexasolr/server/ibexa
    cp /opt/solr/server/solr/configsets/_default/conf/{solrconfig.xml,stopwords.txt,synonyms.txt} /ibexasolr/server/ibexa/template

    # Modify solrconfig.xml to remove the section that doesn't agree with your schema
    sed -i.bak '/<updateRequestProcessorChain name="add-unknown-fields-to-the-schema">/,/<\/updateRequestProcessorChain>/d' /ibexasolr/server/ibexa/template/solrconfig.xml
    sed -i -e 's/<maxTime>${solr.autoSoftCommit.maxTime:-1}<\/maxTime>/<maxTime>${solr.autoSoftCommit.maxTime:20}<\/maxTime>/g' /ibexasolr/server/ibexa/template/solrconfig.xml
    sed -i -e 's/<dataDir>${solr.data.dir:}<\/dataDir>/<dataDir>\/var\/solr\/data\/${solr.core.name}<\/dataDir>/g' /ibexasolr/server/ibexa/template/solrconfig.xml
fi

SOLR_CORES=${SOLR_CORES:-collection1}
CREATE_CORES=false

for core in $SOLR_CORES
do
    if [ ! -d /ibexasolr/server/ibexa/${core} ]; then
        CREATE_CORES=true
        echo "Found missing core: ${core}"
    fi
done

if [ "$CREATE_CORES" = true ]; then
    echo "Start solr on background to create missing cores"
    /opt/solr/bin/solr -s /ibexasolr/server/ibexa

    for core in $SOLR_CORES
    do
        if [ ! -d /ibexasolr/server/ibexa/${core} ]; then
            /opt/solr/bin/solr create_core -c ${core}  -d /ibexasolr/server/ibexa/template
            echo "Core ${core} created."
        fi
    done
    echo "Stop background solr"
    /opt/solr/bin/solr stop
fi

/opt/solr/bin/solr -s /ibexasolr/server/ibexa -f