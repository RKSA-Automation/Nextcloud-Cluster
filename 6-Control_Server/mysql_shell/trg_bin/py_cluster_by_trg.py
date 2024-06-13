import json

selection_options = {
    1: "Create Cluster", 
    2: "Cluster Status",
    3: "Cluster Rescan",
    4: "Add Instance to Cluster", 
    5: "Rejoin Instance to Cluster",
    6: "Remove Instance to Cluster",
    7: "Set Instance as Primary on Cluster",
    8: "Force Qourum Using Partition",
    9: "Revive the Cluster from Complete Outage",
    100: "Exit",
    }

while True:
    try:
        print("\n\nOptions:")

        for key, values in selection_options.items():
            print(f"{key}. {values}.")

        selected_mode = int(input("\nSELECT [Number]: "))
        print(f"\nSelected: {selected_mode}. {selection_options[selected_mode]} ...\n")
        if selected_mode == 100:
            exit()

        elif selected_mode == 1:
            cluster_name = input("Cluster name ( ex. my_cluster ): ")
            cluster = dba.create_cluster(cluster_name)

        elif selected_mode == 2:
            cluster=dba.get_cluster()
            data = cluster.status()
            json_string = json.dumps(data, indent=4)
            print(json_string)
        
        elif selected_mode == 3:
            cluster=dba.get_cluster()
            cluster.rescan()

        elif selected_mode == 4:
            cluster=dba.get_cluster()
            host_uri = input("Insert MYSQL HOST URI ( ex. user@mysql-server-name:3306 ) : ")
            cluster.add_instance(host_uri)
        
        elif selected_mode == 5:
            cluster=dba.get_cluster()
            host_uri = input("Insert MYSQL HOST URI ( ex. user@mysql-server-name:3306 ) : ")
            cluster.rejoin_instance(host_uri)
        
        elif selected_mode == 6:
            cluster=dba.get_cluster()
            host_uri = input("Insert MYSQL HOST URI ( ex. mysql-server-name:3306 ) : ")
            cluster.remove_instance(host_uri)
        
        elif selected_mode == 7:
            cluster=dba.get_cluster()
            host_uri = input("Insert MYSQL HOST URI ( ex. mysql-server-name:3306 ) : ")
            cluster.set_primary_instance(host_uri)
        
        elif selected_mode == 8:
            cluster=dba.get_cluster()
            host_uri = input("Insert MYSQL HOST URI ( ex. user@mysql-server-name:3306 ) : ")
            cluster.forceQuorumUsingPartitionOf(host_uri)
        
        elif selected_mode == 9:
            dba.reboot_cluster_from_complete_outage()

    except Exception as e:
        print(f"\nERROR: {e} ")