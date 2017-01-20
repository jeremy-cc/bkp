export PS1="(\u@\h \w)\$" 
#export PS1=’\u@\h:\W$(__git_ps1 ” (%s)”)\$ ‘
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export M2_HOME=/Users/jeremybotha/java/apache-maven-3.3.9/
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_65.jdk/Contents/Home/
export PATH=$PATH:/Library/Frameworks/JRuby.framework/Versions/Current/bin:/usr/local/mysql/bin:/Users/jeremybotha/java/apache-maven-3.3.9/bin:/Users/jeremybotha/bin
export AWS_CREDENTIAL_FILE=/Users/jeremybotha/.aws/credentials
alias jgemi='sudo jruby -S gem install'
alias ll='ls -la'

CUKE_JAVA_OPTS='-J-Xmx1024m'

alias visvm='jvisualvm --cp:a /Users/jeremybotha/jbossclient/jboss-cli-client.jar' 
alias cuke='RUN_AGAINST=localhost jruby $CUKE_JAVA_OPTS -S cucumber --require=features'
alias cukei='RUN_AGAINST=integ jruby $CUKE_JAVA_OPTS -S bundle exec cucumber --require=features'
alias cuke4='RUN_AGAINST=integ004 jruby $CUKE_JAVA_OPTS -S bundle exec cucumber --require=features'
alias cuket='RUN_AGAINST=prod_test004 jruby-1.6.7.2@cucumber $CUKE_JAVA_OPTS -S bundle exec cucumber --require=features'
alias cuket3='RUN_AGAINST=prod_test003 jruby-1.6.7.2@cucumber $CUKE_JAVA_OPTS -S bundle exec cucumber --require=features'
alias gl='git log --oneline --decorate'
alias gcp='git cherry-pick'

SIEGE_HOME='/Users/jeremyb/development/source/tests/benchmarking/'

function vis_vm {
 (
   JAVA_OPTS="$JAVA_OPTS -Xdebug -Xrunjdwp:transport=dt_socket,address=8787,
    server=y,suspend=n"
   JAVA_OPTS="$JAVA_OPTS -Dcom.sun.management.jmxremote.port=6789"
   JAVA_OPTS="$JAVA_OPTS -Dcom.sun.management.jmxremote.ssl=false"
   JAVA_OPTS="$JAVA_OPTS -Dcom.sun.management.jmxremote.authenticate=false"
   JAVA_OPTS="$JAVA_OPTS -Djava.rmi.server.hostname=192.168.10.10 -Xmx1024m"
   jvisualvm  --cp:a /Users/jeremyb/jbossclient/jboss-cli-client.jar 
 )
}

function deploy_all {
  (
     export TORQUEBOX_HOME=/opt/deploy/torquebox/torquebox-current
     echo deploying all services to $TORQUEBOX_HOME
     local TLDR=/opt/deploy/ccycloud/internal/current
     for APP in crm_engine funds_engine trading_engine payments_engine funds_engine positions_engine notification_service
     do

       echo -en deploying '\E[0;32m'
       echo $APP
       tput sgr0
       cd $TLDR/$APP
       with_tb torquebox deploy .
       sleep 2
     done

  )

}

alias pricecheck="curl http://localhost:38080/pricing/status.json | python -m json.tool | head -28 | tail -24"
alias pricecheckuat="curl http://lon1uat1app001.ccycloud.com:18080/pricing/status.json | python -m json.tool | head -28 | tail -24"
alias pricecheckdemo="curl http://lon1demoapp002.ccycloud.com:18080/pricing/status.json | python -m json.tool | head -28 | tail -24"

alias statsdtunnel="ssh jeremyb@lon1prodmon001 -L 27017:localhost:27017"

alias rubcop="cd ~/development/platform; rubocop -c ./.rubocop.yml"
