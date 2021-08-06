import re
import unidecode


def strip_upper(categoria, regex):
    '''
    Returns a list containing one or more words,
    stripped from a matching regex expression and in upper case.

             Parameters:
                 categoria(list): A list of strings
                 regex(str): A regular expression
    '''
    try:
        for item in range(len(categoria)):
            categoria[item] = unidecode.unidecode(
                re.sub(regex, "", categoria[item].upper()))

    except Exception as error:
        print(error)

    return categoria
