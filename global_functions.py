import re
import unidecode
import numpy as np
import requests
import json
import pandas as pd


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


def map_values_caged(mainDF, valDF, sectorCol, subsCol):
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


def map_values_general(mainDF, valDF, sectorCol, subsCol):
    '''
    Maps 'ano', 'uf', and 'setor' from two
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
                valDF.loc[i, 'uf']) & mainDF[sectorCol].eq(valDF.loc[i, 'setor']))

            mainDF.loc[index[0], subsCol] = valDF.loc[i, subsCol]

    except Exception as error:
        print(error)

    return mainDF


def quote(obj):
    return requests.utils.quote(json.dumps(obj))


def melt_pib(df, colnames, setor):
    '''
    Return an adjusted DataFrame with the structure adjusted to match the
    project standard.

        Paramaters:
            df(pd.DataFrame): Dataset with PIB
            colnames(list): A list containg name of columns to drop
            setor(str): Name of the sector with PIB information
    '''

    df.drop(colnames, axis=1, inplace=True)

    df_a = pd.DataFrame({'uf': df.loc[:, 'Sigla']})
    df_b = df.iloc[:, 1:17]

    df_a = pd.concat([df_a] * df_b.shape[1], ignore_index=True)
    df_a['ano'] = df_b.melt().iloc[:, 0]
    df_a['setor'] = setor
    df_a['pib'] = df_b.melt().iloc[:, 1]

    return(df_a)


def search_info(df, colGen, value, uf, ano):
    '''
    Search for observations matching sector, uf and ano.

        Paramaters:
            df(pd.DataFrame): A dataset
            colGen(str): Name of a specific column to search
            value(str): Value inside colGen to search
            uf(str): Uf to search
            ano(str): Ano to search
    '''
    return df.loc[(df[colGen] == value) & (df['uf'] == uf) & (df['ano'] == ano)]


def dynamic_group(df, vars, dict):
    '''
    Return a dataset grouped with custom rules.

    Args:
        df(pd.DataFrame): A dataset
        vars(list): A list containing variables to be grouped
        dict(dictionary): A dict containing variable:rule set
    '''
    groupDF = df.groupby(vars, as_index=False).agg(dict)
    groupDF.columns = list(map(''.join, groupDF.columns.values))
    return(groupDF)


def self_scatter(df, var, subvar):
    '''
    Returns an adjusted scatterplot.

    args:
        df(DataFrame): A dataset
        var(str): Name of the main variable
        subvar(str): Name of the second variable
    '''

    data = pd.concat([df[var], df[subvar]], axis=1)
    data.plot.scatter(x=subvar, y=var)
