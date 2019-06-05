from sklearn.preprocessing import LabelEncoder, OneHotEncoder
import warnings
warnings.filterwarnings("ignore")

# Correlation metrics
label_encoder = LabelEncoder()
data.iloc[:,0] = label_encoder.fit_transform(data.iloc[:,0]).astype('float64')
corr = data.corr()
sns.heatmap(corr)


# Next, we compare the correlation between features 
# and remove one of two features that have a correlation higher than 0.9
columns = np.full((corr.shape[0],), True, dtype=bool)
for i in range(corr.shape[0]):
    for j in range(i+1, corr.shape[0]):
        if corr.iloc[i,j] >= 0.9:
            if columns[j]:
                columns[j] = False
selected_columns = data.columns[columns]
data = data[selected_columns]

# pvalue feature selection
selected_columns = selected_columns[1:].values

import statsmodels.formula.api as sm

def backward_elimination(x, Y, sl, columns):
    numVars = len(x[0])
    for i in range(0, numVars):
        regressor_OLS = sm.OLS(Y, x).fit()
        maxVar = max(regressor_OLS.pvalues).astype(float)
        if maxVar > sl:
            for j in range(0, numVars - i):
                if (regressor_OLS.pvalues[j].astype(float) == maxVar):
                    x = np.delete(x, j, 1)
                    columns = np.delete(columns, j)
                    
    regressor_OLS.summary()
    return x, columns

SL = 0.05
data_modeled, selected_columns = backward_elimination(data.iloc[:,1:].values, data.iloc[:,0].values, SL, selected_columns)


# Moving the result to a new Dataframe
result = pd.DataFrame()
result['diagnosis'] = data.iloc[:,0]

# Creating a Dataframe with the columns selected using the p-value and correlation
fs_data = pd.DataFrame(data = data_modeled, columns = selected_columns)