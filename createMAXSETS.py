import pandas as pd
import networkx as nx
import matplotlib.pyplot as plt
from io import StringIO
import time
import random
import numpy as np
#Example of a compatibility matrix
"""
csv_data = """
1,0,0,0,1
1,0,1,0,1
0,1,0,1,0
1,0,1,1,0
"""
""" #End of example of a compatibility matrix
start = time.time()

def read_2d_table_from_txt(file_path):
    try:
        # Read the text file
        with open(file_path, 'r') as file:
            lines = file.readlines()

        # Convert the lines into a 2D array
        table = []
        for line in lines:
            row = list(map(int, line.strip().split()))
            table.append(row)

        # Convert the list of lists into a 2D numpy array
        np_table = np.array(table)

        return np_table
    except FileNotFoundError as e:
        print(f"File not found: {file_path}")
        return None
    except Exception as e:
        print(f"Error occurred while reading the file: {e}")
        return None
# Specify the path to your input file and output file


def replace_commas_with_spaces(input_file, output_file):
    try:
        # Open the input file for reading
        with open(input_file, 'r') as file:
            # Read the content of the file
            file_content = file.read()

        # Replace commas with spaces
        modified_content = file_content.replace(',', ' ')

        # Open the output file for writing
        with open(output_file, 'w') as file:
            # Write the modified content back to the file
            file.write(modified_content)

        print("Commas replaced with spaces. Output written to", output_file)

    except FileNotFoundError:
        print("Input file not found. Please provide a valid input file path.")
    except Exception as e:
        print("An error occurred:", str(e))



# Read the CSV data into a DataFrame
for index in range(1, 51): #change the range to the number of graphs
    name='C..'+'CM'+str(index)+'.txt' #change to desired path

    input_file = name
    output_file = str(index)+'new.txt' #replace commas with spaces
    replace_commas_with_spaces(input_file, output_file)
    total_hop_table=read_2d_table_from_txt(output_file)

    df = pd.DataFrame(data = total_hop_table)
    #print(df)

    # Get the number of nodes based on the DataFrame shape
    num_nodes = df.shape[0]

    isolated_nodes = []
    for i in range(num_nodes):
        if (df.iloc[:, i] < 1).any() or (df.iloc[i, :] <1).any():
            continue
        isolated_nodes.append(f"Node {i + 1}")

    #Isolated nodes are the nodes that do not have compatibility with any other link, so they contitute a MCLS themselves.
    print("Isolated nodes:", isolated_nodes)
    

    # Create a graph based on the distances
    G = nx.Graph()
    for i in range(num_nodes):
        for j in range(i + 1, num_nodes):
            hops = df.iloc[i, j]
            if hops >= 1:
                G.add_edge(f"Node {i + 1}", f"Node {j + 1}", hops=hops)


    # Find and print all maximal cliques of compatibility graph
    maximal_cliques = list(nx.find_cliques(G)) 
    file_path = "output.txt"
    with open(file_path, "w") as file:
        for i, clique in enumerate(maximal_cliques, start=1):
            clique_str = ", ".join(map(str, clique))
            while "Node" in clique_str:
                clique_str = clique_str.replace("Node", "", 1)
            file.write(clique_str + "\n")
    end = time.time()
    print(end - start)


    # Set the file paths
    source_file_path = 'output.txt'  # Store intermediate results
    destination_file_path = 'random_lines.txt'  # Store intermediate results

    # Set the number of MCLSs you need
    num_random_lines =  len(maximal_cliques) # Change this to the desired number of lines all: len(maximal_cliques)  

    # Open the source file for reading
    with open(source_file_path, 'r') as source_file:
        # Read all lines from the source file and store them in a list
        all_lines = source_file.readlines()

    # Select random lines from the list
    random_lines = random.sample(all_lines, num_random_lines)

    # Open the destination file for writing
    with open(destination_file_path, 'w') as destination_file:
        # Write the selected random lines to the destination file
        destination_file.writelines(random_lines)


    Cliques = np.zeros((num_random_lines, num_nodes))

    # Read the text file line by line
    with open('random_lines.txt', 'r') as file:
        for row, line in enumerate(file):
            # Split the line into individual values
            values = list(map(int, line.strip().split(',')))

            # Set the elements at the specified columns to 1 (aces)
            for col in values:
                Cliques[row, col - 1] = 1  # Subtract 1 because Python uses 0-based indexing

    # Print the resulting MCLSs
    print(Cliques)

    np.savetxt(str(index)+'.csv', Cliques, delimiter=',', fmt='%d') #Important: remember the file name, because it will be given as input to the matlab code.