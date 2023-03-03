import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier


def train_test_response(result_file):
    df = pd.read_csv('modal/BBB.csv')

    X = df[['Molecular_Weight','Hydrogen_bond_Acceptor','Hydrogen_bond_Donor','xlogP','Physiological_Charge','Polarized_Surface_Area']]
    y = df['BBB']

    X_train,X_test,y_train,y_test = train_test_split(X,y,test_size=0.3,random_state=0)

    clf = RandomForestClassifier(n_estimators=200)
    clf.fit(X_train,y_train)
    y_pred=clf.predict(X_test)

    # final data
    pk = pd.read_csv (result_file)
    pk_pred=clf.predict(pk)
    return pk_pred

