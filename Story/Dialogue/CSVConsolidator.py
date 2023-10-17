import csv

def main():
    """
    with open('NPC1/State1/Dialogue.csv','r') as csv_file:
        csv_reader = csv.DictReader(csv_file,["Id","Description","Modifier"])
        for row in csv_reader:
            print(row["Id"],row["Description"],row["Modifier"])"""
    
    NPC = input("Please enter the npc folder location (with / at the end): ")
    State = input("Please enter the path for the state (without / at the end): ")
    nodes = []
    edges = []
    preorder_tree_to_list(nodes, edges, NPC + State + "/", 0, "")
    print(nodes)
    print(edges)
    
    with open(State + 'Nodes.csv','w') as csv_file:
        csv_writer = csv.DictWriter(csv_file, ["Id","Description","Modifier"])

        for row in nodes:
            csv_writer.writerow(row)
    
    with open(State + 'Edges.csv','w') as csv_file:
        csv_writer = csv.DictWriter(csv_file, ["Parent","Current","Text"])

        for row in edges:
            csv_writer.writerow(row)

def preorder_tree_to_list(node_list, edge_list, path, parent_index, from_text):
    with open(path + "Dialogue.csv",'r') as csv_file:
        is_first_line = True
        csv_reader = csv.DictReader(csv_file,["Id","Description","Modifier"])
        current_list_position = len(node_list)
        for row in csv_reader:
            if is_first_line:
                is_first_line = False
                node_list.append(row)
                if parent_index != current_list_position:
                    edge_list.append({"Parent":parent_index,"Current":current_list_position,"Text":from_text})
            else:
                preorder_tree_to_list(node_list, edge_list, path + "Decision" + row["Id"] + "/", current_list_position, row["Description"])
    

if __name__ == "__main__":
    main()