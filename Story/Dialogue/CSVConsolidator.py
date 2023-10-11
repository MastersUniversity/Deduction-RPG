import csv

def main():
    """
    with open('NPC1/State1/Dialogue.csv','r') as csv_file:
        csv_reader = csv.DictReader(csv_file,["Id","Description","Modifier"])
        for row in csv_reader:
            print(row["Id"],row["Description"],row["Modifier"])"""
    nodes = [()]
    edges = []
    preorder_tree_to_list(nodes, edges, "NPC1/State1/", 0, "")
    print(nodes)
    print(edges)
    with open('NPC1/State1/Dialogue.csv','r') as csv_file:
        csv_writer = csv.DictWriter(csv_file, ["Id","Description","Modifier"])
        for row in nodes:
            csv_writer.writerow()

def preorder_tree_to_list(node_list, edge_list, path, parent_index, from_text):
    with open(path + "Dialogue.csv",'r') as csv_file:
        is_first_line = True
        csv_reader = csv.DictReader(csv_file,["Id","Description","Modifier"])
        current_list_position = len(node_list)
        for row in csv_reader:
            if is_first_line:
                is_first_line = False
                node_list.append((row["Id"],row["Description"],row["Modifier"]))
                edge_list.append((parent_index,current_list_position,from_text))
            else:
                preorder_tree_to_list(node_list, edge_list, path + "Decision" + row["Id"] + "/", current_list_position, row["Description"])
    

if __name__ == "__main__":
    main()