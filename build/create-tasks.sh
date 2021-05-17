echo "Create tasks..."
oc create --save-config=true -f image-streams/imageStream-shane-rest-app.yaml 
oc create --save-config=true -f persistentVolumes/task-cache-pvc.yaml 
oc create --save-config=true -f resources/imageStreamResource-intermediate.yaml 
oc create --save-config=true -f resources/imageStreamResource-shane-rest-app.yaml 
oc create --save-config=true -f resources/sourceCode-GitResource.yaml 
oc create --save-config=true -f tasks/build.yaml 
oc create --save-config=true -f tasks/clearBuildahRepo.yaml 
oc create --save-config=true -f tasks/clearResources.yaml 
oc create --save-config=true -f tasks/createRuntimeImage.yaml 
oc create --save-config=true -f tasks/ocProcessDeploymentTemplate.yaml 
oc create --save-config=true -f tasks/pushImageToQuay.yaml
oc create --save-config=true -f pipelines/pipeline.yaml
echo "Add privileged user..."
oc adm policy add-scc-to-user privileged -z default -n shane-rest
oc adm policy add-scc-to-user privileged -z builder -n shane-rest
oc adm policy add-scc-to-user privileged -z deployer -n shane-rest
oc adm policy add-scc-to-user privileged -z pipeline -n shane-rest
echo "Creat quay secret..."
oc create --save-config=true -f shaneva-secret.yaml