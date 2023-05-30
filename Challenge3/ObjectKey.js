var obj = {"x1":{"y1":{"z1":"a1"}}}

var keys = ['x1', 'y1', 'z1']


//Function
const getValueFromKeys = (obj, keys, defaultValue)=> (Array.isArray(keys)?keys:keys.split('.')).reduce((acc,key)=>acc[key] || defaultValue, obj)


//Output
console.log(getValueFromKeys(obj, 'x1.y1.z1'));
console.log(getValueFromKeys(obj, 'x1.y1'));
console.log(getValueFromKeys(obj, 'x1'));
