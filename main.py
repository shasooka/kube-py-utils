
from kubernetes import client, config

def api():
    try:
        config.load_kube_config()
        v1 = client.CoreV1Api()
    except:
        print("exeception")
    return(v1)

def get_pods(v1):
    print("Listing pods with their IPs:")
    ret = v1.list_pod_for_all_namespaces(watch=False)
    for i in ret.items:
        print("%s\t%s\t%s" %
              (i.status.pod_ip, i.metadata.namespace, i.metadata.name))

def get_images(v1):
    print("Listing all images:")
    ret = v1.list_pod_for_all_namespaces(watch=False)
    for i in ret.items:       
        for j in i.spec.containers:
            print("%s\t%s\t%s" %
              (i.metadata.name, i.metadata.namespace, j.image))
        if i.spec.init_containers is not None:
            for j in i.spec.init_containers:
                print("%s\t%s\t%s" %
                    (i.metadata.name, i.metadata.namespace, j.image))

def main():
    v1 = api()
    # get_pods(v1)
    get_images(v1)
"""
Triggers the function only if it invoked as main 
"""
if __name__ == '__main__':
    main()