function pp {
    pipenv run pulumi preview $@
}

function pu {
    pipenv run pulumi up $@
}

function pd {
    pipenv run pulumi destroy $@
}

function pstack {
    pipenv run pulumi stack select $@
}

function pi {
    pipenv run pulumi import $@
}