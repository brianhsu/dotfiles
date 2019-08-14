function markAsDone() {
    if [ "$#" -ne 1 ]; then
        echo "Must provide taskId"
    else
        task $1 done
    fi
}

function trash() {
    if [ "$#" -ne 1 ]; then
        echo "Must provide taskId"
    else
        task $1 delete
    fi
}

function next() {

    re='^[0-9]+$'

    if [ "$#" -lt 1 ]; then
        task 
    elif ! [[ $1 =~ $re ]]; then
        task add +next $@
    else
        taskId=$1
        shift
        task $taskId modify -inbox +next $@
    fi
}

function moveToProject() {
    if [ "$#" -lt 2 ]; then
        echo "Must provide taskId and project name"
    else
        taskId=$1
        projectName=$2
        shift 2
        task $taskId modify -inbox +next pro:$projectName $@
        task add +placeholder project:$projectName 將專案標記為完成
    fi
}

function newProject() {
    if [ "$#" -lt 1 ]; then
        echo "Must provide projectName"
    else
        projectName=$1
        shift 1
        task add +placeholder project:$projectName 將專案標記為完成 $@
    fi

}

function project() {
    if [ "$#" -lt 1 ]; then
        task project
        task summary
    elif [ "$#" -eq 1 ]; then
        taskId=$1
        projectName=`task _get $taskId.description`
        shift
        task $taskId modify +placeholder -inbox project:$projectName 將專案標記為完成 $@
    else
        taskId=$1
        projectName=$2
        shift 2
        task $taskId modify +placeholder -inbox project:$projectName 將專案標記為完成 $@
    fi
}

function maybe() {
    if [ "$#" -lt 1 ]; then
        task maybe
    else
        taskId=$1
        shift
        task $taskId modify wait:someday $@
    fi
}

function inbox() {
    if [ "$#" -lt 1 ]; then
        task inbox
    else
        task +inbox add $@
    fi

}

function tickle () {
    if [ "$#" -lt 2 ]; then
        task tickle
    else
        taskId=$1
        deadline=$2
        shift 2
        task $taskId modify wait:$deadline $@
    fi
}


function notify() {
    if [ "$#" -lt 1 ]; then
        task delegated notified:
    else
        taskId=$1
        shift
        task $taskId modify notified:V $@
    fi
}

function delegated() {
    re='^[0-9]+$'


    if [ "$#" -lt 2 ]; then
        task delegated
    elif ! [[ $1 =~ $re ]]; then
        assignee=$1
        shift 1
        task add delegated:$assignee +delegated $@
    else
        taskId=$1
        assignee=$2
        shift 2
        task $taskId modify delegated:$assignee +delegated -inbox $@
    fi
}

function scheduled() {
    re='^[0-9]+$'

    if [ "$#" -lt 2 ]; then
        task scheduled
    elif ! [[ $1 =~ $re ]]; then
        scheduled=$1
        shift 1
        task add +scheduled scheduled:$scheduled due:scheduled+1d $@
    else
        taskId=$1
        scheduled=$2
        shift 2
        task $taskId modify +scheduled -inbox scheduled:$scheduled due:scheduled+1d $@
    fi

}

alias tickle=tickle
alias inbox=inbox
alias check=markAsDone
alias trash=trash
alias next=next
alias project=project
alias maybe=maybe
alias moveToProject=moveToProject
alias delegated=delegated
alias newProject=newProject
