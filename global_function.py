import re
import unidecode
import numpy as np


def strip_upper(category, regex):
    '''
    Returns a list containing one or more words in upper case,
    stripped from special characters from a matching regex expression.

             Parameters:
                 category(list): A list of strings
                 regex(str): A regular expression
    '''
    try:
        for item in range(len(category)):
            category[item] = unidecode.unidecode(
                re.sub(regex, "", category[item].upper()))

    except Exception as error:
        print(error)

    return category


def map_values(mainDF, valDF, sectorCol, subsCol):
    '''
    Maps 'ano', 'uf', 'porte_do_cliente', and 'setor' from two
    datasets and returns the main dataset with a new column filled with
    matched information from a column from the second dataset.

        Parameters:
            mainDF(pd.DataDrame): A pd.DataFrame
            valDF(pd.DataDrame): A pd.DataFrame
            sectorCol(str): Name of the column with sector categories from the main dataset
            subsCol: Name of the column from the seconda dataset to map to the main dataset
    '''

    try:
        for i in range(len(valDF)):
            index = np.where(mainDF['ano'].eq(valDF.loc[i, 'ano']) & mainDF['uf'].eq(
                valDF.loc[i, 'uf']) & mainDF['porte_do_cliente'].eq(
                valDF.loc[i, 'porte_do_cliente']) & mainDF[sectorCol].eq(valDF.loc[i, 'setor']))

            mainDF.loc[index[0], subsCol] = valDF.loc[i, subsCol]

    except Exception as error:
        print(error)

    return mainDF
