# importing data set
import pandas as pd
Wind_turbine_py=pd.read_csv(r'C:\Users\kasup\OneDrive\Desktop\Project\Data Sets (6)\Wind_turbine.csv')


Wind_turbine_py.info()
Wind_turbine_py.shape
Wind_turbine_py.head(5)
# identify duplicate records
duplicate = Wind_turbine_py.duplicated()
sum(duplicate)

#DESCRIPTIVE ANALYTICS / STATISTICS

#First moment business decision (Concentration of data)
Wind_turbine_py.mean()
Wind_turbine_py.median()
Wind_turbine_py.Failure_status.mode()

#Second moment business decision (how data/data points are distributed, distance from centre)
Wind_turbine_py.std()
Wind_turbine_py.var()


max(Wind_turbine_py.Wind_speed)-min(Wind_turbine_py.Wind_speed)
max(Wind_turbine_py.Power)-min(Wind_turbine_py.Power)
max(Wind_turbine_py.Nacelle_ambient_temperature)-min(Wind_turbine_py.Nacelle_ambient_temperature)
max(Wind_turbine_py.Generator_bearing_temperature)-min(Wind_turbine_py.Generator_bearing_temperature)
max(Wind_turbine_py.Gear_oil_temperature)-min(Wind_turbine_py.Gear_oil_temperature)
max(Wind_turbine_py.Ambient_temperature)-min(Wind_turbine_py.Ambient_temperature)
max(Wind_turbine_py.Rotor_Speed)-min(Wind_turbine_py.Rotor_Speed)
max(Wind_turbine_py.Nacelle_temperature)-min(Wind_turbine_py.Nacelle_temperature)
max(Wind_turbine_py.Bearing_temperature)-min(Wind_turbine_py.Bearing_temperature)
max(Wind_turbine_py.Generator_speed)-min(Wind_turbine_py.Generator_speed)
max(Wind_turbine_py.Yaw_angle)-min(Wind_turbine_py.Yaw_angle)
max(Wind_turbine_py.Wind_direction)-min(Wind_turbine_py.Wind_direction)
max(Wind_turbine_py.Wheel_hub_temperature)-min(Wind_turbine_py.Wheel_hub_temperature)
max(Wind_turbine_py.Gear_box_inlet_temperature)-min(Wind_turbine_py.Gear_box_inlet_temperature)


#Third moment business decision (whether data is normally distributed or not)
Wind_turbine_py.skew()

#Fourth moment business decision (Peakedness)
Wind_turbine_py.kurt()

#DATA PREPARATION
#data cleansing - removed unneccessary column
Wind_turbine_py=Wind_turbine_py.drop(['Unnamed: 16'],axis=1)
#zero variance
Wind_turbine_py.var==0
Wind_turbine_py.var(axis=0)==0

#data organisisng - well structured

#handling duplicates
duplicate=Wind_turbine_py.duplicated()
sum(duplicate)
#there are no duplicates


#renaming column name
Wind_turbine_py=Wind_turbine_py.rename(columns={'Bearing_temperature)':'Bearing_temperature'})

#OUTIER TREATMENT
#checking for outliers
import seaborn as sns
sns.boxplot(Wind_turbine_py.Wind_speed)
sns.boxplot(Wind_turbine_py.Power)
sns.boxplot(Wind_turbine_py.Nacelle_ambient_temperature)
sns.boxplot(Wind_turbine_py.Generator_bearing_temperature)
sns.boxplot(Wind_turbine_py.Gear_oil_temperature)
sns.boxplot(Wind_turbine_py.Ambient_temperature )
sns.boxplot(Wind_turbine_py.Rotor_Speed)
sns.boxplot(Wind_turbine_py.Nacelle_temperature)
sns.boxplot(Wind_turbine_py.Bearing_temperature)
sns.boxplot(Wind_turbine_py.Generator_speed)
sns.boxplot(Wind_turbine_py.Yaw_angle)
sns.boxplot(Wind_turbine_py.Wind_direction)
sns.boxplot(Wind_turbine_py.Wheel_hub_temperature) #no outliers
sns.boxplot(Wind_turbine_py.Gear_box_inlet_temperature)

#what are the outlying data points and no. of outliers

import numpy as np
iqr=Wind_turbine_py.Wind_speed.quantile(0.75)-Wind_turbine_py.Wind_speed.quantile(0.25)
upper=Wind_turbine_py.Wind_speed.quantile(0.75)+(1.5*iqr)
lower=Wind_turbine_py.Wind_speed.quantile(0.25)-(1.5*iqr)

outliers=np.where(Wind_turbine_py.Wind_speed > upper,True,np.where(Wind_turbine_py.Wind_speed < lower,True,False))
a=Wind_turbine_py.loc[outliers]
a.Wind_speed.count()

#identify missing values
Wind_turbine_py.date.isna().sum()
Wind_turbine_py.Wind_speed.isna().sum()
Wind_turbine_py.Power.isna().sum()
Wind_turbine_py.Nacelle_ambient_temperature.isna().sum()
Wind_turbine_py.Generator_bearing_temperature.isna().sum()
Wind_turbine_py.Gear_oil_temperature.isna().sum()
Wind_turbine_py.Ambient_temperature.isna().sum()
Wind_turbine_py.Rotor_Speed.isna().sum()
Wind_turbine_py.Nacelle_temperature.isna().sum()
Wind_turbine_py.Bearing_temperature.isna().sum()
Wind_turbine_py.Generator_speed.isna().sum()
Wind_turbine_py.Yaw_angle.isna().sum()
Wind_turbine_py.Wind_direction.isna().sum()
Wind_turbine_py.Wheel_hub_temperature.isna().sum()
Wind_turbine_py.Gear_box_inlet_temperature.isna().sum()
Wind_turbine_py.Failure_status.isna().sum()

#imputation
from sklearn.impute import SimpleImputer
import numpy as np

#there exists outliers/extreme values mean value is influenced by outliers so use median imputer
median_imputer = SimpleImputer(missing_values = np.nan, strategy = 'median')
Wind_turbine_py['Wind_speed'] = pd.DataFrame(median_imputer.fit_transform(Wind_turbine_py[['Wind_speed']]))
Wind_turbine_py['Power'] = pd.DataFrame(median_imputer.fit_transform(Wind_turbine_py[['Power']]))
Wind_turbine_py['Nacelle_ambient_temperature'] = pd.DataFrame(median_imputer.fit_transform(Wind_turbine_py[['Nacelle_ambient_temperature']]))
Wind_turbine_py['Nacelle_temperature'] = pd.DataFrame(median_imputer.fit_transform(Wind_turbine_py[['Nacelle_temperature']]))
Wind_turbine_py['Generator_speed'] = pd.DataFrame(median_imputer.fit_transform(Wind_turbine_py[['Generator_speed']]))
Wind_turbine_py['Yaw_angle'] = pd.DataFrame(median_imputer.fit_transform(Wind_turbine_py[['Yaw_angle']]))
Wind_turbine_py['Gear_box_inlet_temperature'] = pd.DataFrame(median_imputer.fit_transform(Wind_turbine_py[['Gear_box_inlet_temperature']]))


#retaining outliers using winsorization/ iqr method
from feature_engine.outliers import Winsorizer
winsor_iqr = Winsorizer(capping_method = 'iqr', 
                           tail = 'both', 
                           fold = 1.5, 
                           variables = ['Wind_speed','Power','Nacelle_ambient_temperature','Generator_bearing_temperature','Gear_oil_temperature'
                                        ,'Ambient_temperature','Rotor_Speed','Nacelle_temperature','Bearing_temperature','Generator_speed',
                                        'Yaw_angle','Wind_direction','Gear_box_inlet_temperature'])
Wind_turbine_py = winsor_iqr.fit_transform(Wind_turbine_py[['date','Wind_speed','Power','Nacelle_ambient_temperature','Generator_bearing_temperature','Gear_oil_temperature'
             ,'Ambient_temperature','Rotor_Speed','Nacelle_temperature','Generator_speed','Bearing_temperature',
             'Yaw_angle','Wind_direction','Wheel_hub_temperature','Gear_box_inlet_temperature','Failure_status']])



'''no need for discretization/binarisation i.e,numerical to categorical
no need to change categorical to numerical i.e,one hot / label encoding

feature engineering - adding extra column may be unnecessary'''

'''-------------------------------DUMMY VARIABLE CREATION----------------------------------------
Wind_turbine_py['Failure_status']=pd.get_dummies(Wind_turbine_py.Failure_status,drop_first=True)

----------------------------------------ONE HOT ENCODING-----------------------------------------
from sklearn.preprocessing import OneHotEncoder
one = OneHotEncoder()

-----------------------------------------LABEL ENCODING------------------------------------------
Wind_turbine_py=pd.DataFrame(one.fit_transform(Wind_turbine_py.iloc[:,15:16]).toarray())
from sklearn.preprocessing import LabelEncoder
label=LabelEncoder()
X=Wind_turbine_py.iloc[:,:]
Y=Wind_turbine_py.iloc[:,:]
Wind_turbine_py['Failure_status']=label.fit_transform(X['Failure_status'])
Wind_turbine_py.Failure_status.value_counts()

-------------------------------------DISCRETISATION/BINARISATION--------------------------------
Wind_turbine_py['Wind_speed']=pd.cut(Wind_turbine_py['Wind_speed'],
                                     bins=[min(Wind_turbine_py['Wind_speed']),
                                              Wind_turbine_py['Wind_speed'].mean(),
                                              max(Wind_turbine_py['Wind_speed'])],
                                     include_lowest=True,
                                     labels=["low",'high'])'''



# UNIVARIENT ANALYSIS
#Check for normal distribution
import scipy.stats as stats
import pylab
stats.probplot(Wind_turbine_py.Wind_speed,dist='norm',plot=pylab)
stats.probplot(Wind_turbine_py.Power,dist='norm',plot=pylab)
stats.probplot(Wind_turbine_py.Nacelle_ambient_temperature,dist='norm',plot=pylab)
stats.probplot(Wind_turbine_py.Generator_bearing_temperature,dist='norm',plot=pylab)
stats.probplot(Wind_turbine_py.Gear_oil_temperature,dist='norm',plot=pylab)
stats.probplot(Wind_turbine_py.Ambient_temperature ,dist='norm',plot=pylab)
stats.probplot(Wind_turbine_py.Rotor_Speed,dist='norm',plot=pylab)
stats.probplot(Wind_turbine_py.Nacelle_temperature,dist='norm',plot=pylab)
stats.probplot(Wind_turbine_py.Bearing_temperature,dist='norm',plot=pylab)
stats.probplot(Wind_turbine_py.Generator_speed,dist='norm',plot=pylab)
stats.probplot(Wind_turbine_py.Yaw_angle,dist='norm',plot=pylab)
stats.probplot(Wind_turbine_py.Wind_direction,dist='norm',plot=pylab)
stats.probplot(Wind_turbine_py.Wheel_hub_temperature,dist='norm',plot=pylab)
stats.probplot(Wind_turbine_py.Gear_box_inlet_temperature,dist='norm',plot=pylab)


#Analysing the distribution
import matplotlib.pyplot as plt
plt.hist(Wind_turbine_py.Wind_speed,color='yellow',edgecolor='black')
plt.hist(Wind_turbine_py.Power,color='yellow',edgecolor='black')
plt.hist(Wind_turbine_py.Nacelle_ambient_temperature,color='yellow',edgecolor='black')
plt.hist(Wind_turbine_py.Generator_bearing_temperature,color='yellow',edgecolor='black')
plt.hist(Wind_turbine_py.Ambient_temperature,color='yellow',edgecolor='black')
plt.hist(Wind_turbine_py.Generator_speed,color='yellow',edgecolor='black')
plt.hist(Wind_turbine_py.Wheel_hub_temperature,color='yellow',edgecolor='black')


#BI VARIENT ANALYSIS
#relation b/w input and output variable
plt.scatter(x=Wind_turbine_py['Wind_speed'], y=Wind_turbine_py['Power'], color='red')
plt.scatter(x=Wind_turbine_py['Wind_speed'], y=Wind_turbine_py['Generator_speed'], color='red')

Wind_turbine_py.corr(method='pearson')

#MULTIVARIENT ANALYSIS
import seaborn as sns
sns.pairplot(Wind_turbine_py)

#TRANSFORMATION 
import scipy.stats as stats
import pylab
stats.probplot(np.log(Wind_turbine_py.Wind_speed),dist='norm',plot=pylab)
stats.boxcox(Wind_turbine_py.Power)
from feature_engine import transformation

power=transformation.YeoJohnsonTransformer(variables='Power')
Wind_turbine_py['Power']=power.fit_transform(Wind_turbine_py[['Power']])

windspeed=transformation.YeoJohnsonTransformer(variables='Wind_speed')
Wind_turbine_py['Wind_speed']=windspeed.fit_transform(Wind_turbine_py[['Wind_speed']])

nat=transformation.YeoJohnsonTransformer(variables='Nacelle_ambient_temperature')
Wind_turbine_py['Nacelle_ambient_temperature']=nat.fit_transform(Wind_turbine_py[['Nacelle_ambient_temperature']])

gbt=transformation.YeoJohnsonTransformer(variables='Generator_bearing_temperature')
Wind_turbine_py['Generator_bearing_temperature']=gbt.fit_transform(Wind_turbine_py[['Generator_bearing_temperature']])

got=transformation.YeoJohnsonTransformer(variables='Gear_oil_temperature')
Wind_turbine_py['Gear_oil_temperature']=got.fit_transform(Wind_turbine_py[['Gear_oil_temperature']])

at=transformation.YeoJohnsonTransformer(variables='Ambient_temperature')
Wind_turbine_py['Ambient_temperature']=at.fit_transform(Wind_turbine_py[['Ambient_temperature']])


rs=transformation.YeoJohnsonTransformer(variables='Rotor_Speed')
Wind_turbine_py['Rotor_Speed']=rs.fit_transform(Wind_turbine_py[['Rotor_Speed']])


nt=transformation.YeoJohnsonTransformer(variables='Nacelle_temperature')
Wind_turbine_py['Nacelle_temperature']=nt.fit_transform(Wind_turbine_py[['Nacelle_temperature']])


bt=transformation.YeoJohnsonTransformer(variables='Bearing_temperature')
Wind_turbine_py['Bearing_temperature']=bt.fit_transform(Wind_turbine_py[['Bearing_temperature']])

gs=transformation.YeoJohnsonTransformer(variables='Generator_speed')
Wind_turbine_py['Generator_speed']=gs.fit_transform(Wind_turbine_py[['Generator_speed']])

yw=transformation.YeoJohnsonTransformer(variables='Yaw_angle')
Wind_turbine_py['Yaw_angle']=yw.fit_transform(Wind_turbine_py[['Yaw_angle']])


wd=transformation.YeoJohnsonTransformer(variables='Wind_direction')
Wind_turbine_py['Wind_direction']=wd.fit_transform(Wind_turbine_py[['Wind_direction']])

wht=transformation.YeoJohnsonTransformer(variables='Wheel_hub_temperature')
Wind_turbine_py['Wheel_hub_temperature']=wht.fit_transform(Wind_turbine_py[['Wheel_hub_temperature']])

gbit=transformation.YeoJohnsonTransformer(variables='Gear_box_inlet_temperature')
Wind_turbine_py['Gear_box_inlet_temperature']=gbit.fit_transform(Wind_turbine_py[['Gear_box_inlet_temperature']])

#DATA SCALING -
#STANDARDISATION
from sklearn.preprocessing import StandardScaler
scaler = StandardScaler()
Wind_turbine_py['Wind_speed']=scaler.fit_transform(Wind_turbine_py[['Wind_speed']])
Wind_turbine_py['Power']=scaler.fit_transform(Wind_turbine_py[['Power']])
Wind_turbine_py['Nacelle_ambient_temperature']=scaler.fit_transform(Wind_turbine_py[['Nacelle_ambient_temperature']])
Wind_turbine_py['Generator_bearing_temperature']=scaler.fit_transform(Wind_turbine_py[['Generator_bearing_temperature']])
Wind_turbine_py['Gear_oil_temperature']=scaler.fit_transform(Wind_turbine_py[['Gear_oil_temperature']])
Wind_turbine_py['Ambient_temperature']=scaler.fit_transform(Wind_turbine_py[['Ambient_temperature']])
Wind_turbine_py['Rotor_Speed']=scaler.fit_transform(Wind_turbine_py[['Rotor_Speed']])
Wind_turbine_py['Nacelle_temperature']=scaler.fit_transform(Wind_turbine_py[['Nacelle_temperature']])
Wind_turbine_py['Bearing_temperature']=scaler.fit_transform(Wind_turbine_py[['Bearing_temperature']])
Wind_turbine_py['Wheel_hub_temperature']=scaler.fit_transform(Wind_turbine_py[['Wheel_hub_temperature']])
Wind_turbine_py['Gear_box_inlet_temperature']=scaler.fit_transform(Wind_turbine_py[['Gear_box_inlet_temperature']])
Wind_turbine_py['Generator_speed']=scaler.fit_transform(Wind_turbine_py[['Generator_speed']])
Wind_turbine_py['Yaw_angle']=scaler.fit_transform(Wind_turbine_py[['Yaw_angle']])
Wind_turbine_py['Wind_direction']=scaler.fit_transform(Wind_turbine_py[['Wind_direction']])

Wind_turbine_py

#NORMALISATION
from sklearn.preprocessing import MinMaxScaler
minmax = MinMaxScaler()
Wind_turbine_py['Wind_direction']=minmax.fit_transform(Wind_turbine_py[['Wind_direction']])














