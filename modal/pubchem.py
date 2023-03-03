from pubchempy import get_compounds
import csv
from .py_model import *
import pandas as pd


def get_response(user_input):
    response_dict = {'status': 0, 'message': 'No entry in pubchem database.'}
    try:
        with open('modal/result.csv', 'w') as file:
            writer = csv.writer(file)
            col_name = ["Molecular_Weight","Hydrogen_bond_Acceptor","Hydrogen_bond_Donor","xlogP","Physiological_Charge","Polarized_Surface_Area"]
            writer.writerow(col_name)
            compounds=get_compounds(user_input, 'smiles')
            print(compounds)
            if not compounds:
                return response_dict
            
            for cm in compounds:
                col_value = [cm.molecular_weight,cm.h_bond_acceptor_count,cm.h_bond_donor_count,cm.xlogp,cm.charge,cm.tpsa]
                writer.writerow(col_value)
                break
            response_dict = dict(zip(col_name, col_value))
        
        response = train_test_response('modal/result.csv')
        response_dict['status'] = response[0]
        if response[0] == 1:
            response_dict['message'] = "BBB permeable"
        else:
            response_dict['message'] = "BBB impermeable"
    except Exception as e:
        print(e)

    return response_dict
