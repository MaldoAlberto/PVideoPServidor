----------------------------------------------------------------------
-- This script shows how to train different models on the CIFAR
-- dataset, using multiple optimization techniques (SGD, ASGD, CG)
--
-- This script demonstrates a classical example of training
-- well-known models (convnet, MLP, logistic regression)
-- on a 10-class classification problem.
--
-- It illustrates several points:
-- 1/ description of the model
-- 2/ choice of a loss function (criterion) to minimize
-- 3/ creation of a dataset as a simple Lua table
-- 4/ description of training and test procedures
--
-- Clement Farabet
----------------------------------------------------------------------

require 'torch'
require 'nn'
require 'nnx'
require 'dok'
require 'image'
require 'cudnn'
----------------------------------------------------------------------
-- set options

-- fix seed
torch.manualSeed(1)
-- set number of threads
torch.setnumthreads(8)
--torch.setdefaulttensortype('torch.DoubleTensor')
torch.setdefaulttensortype('torch.FloatTensor')
-- classname for cifar 10
classes={'nada','azul','blanca' ,'patas'}

print('load pretrained network file')

network=torch.load('model.net')


--cudnn.convert(network, nn)
--model= network:float()

model= network:cuda()

   model:evaluate()
--model=torch.load('model.net')
--torch.save('cifar.net.ascii', model, 'ascii')


--model=torch.load('cifar.net.ascii', 'ascii')
--torch.save('cifar.net.bi', model, 'binary')
--model=torch.load('cifar.net.bi')


parameters,gradParameters = model:getParameters()

--model:add(nn.LogSoftMax())
criterion = nn.ClassNLLCriterion()
   criterion:cuda()
-- read mean & std values
mean_u=torch.load('mean_u_sillas')
--print('mean_u ' .. mean_u)
mean_v=torch.load('mean_v_sillas')
--print('mean_v ' .. mean_v)
std_u=torch.load('std_u_sillas')
--print('std_u ' .. std_u)
std_v=torch.load('std_v_sillas')
--print('std_v ' .. std_v)




-- function for test image
function getRecogResult(sampledata)


  sampledata = sampledata:reshape(3,32,32)
image.saveJPG('foto.jpg',sampledata)
 -- data = torch.DoubleTensor():set(sampledata)
data = torch.FloatTensor():set(sampledata)

--data=sampledata:cuda()

  normalization = nn.SpatialContrastiveNormalization(1, image.gaussian1D(13))
  -- preprocess testSet

  --print 'rgb -> yuv'
  local rgb = data

  local yuv = image.rgb2yuv(rgb)



  -- print 'normalize y locally'
  yuv[1] = normalization(yuv[{{1}}])
  data = yuv

  -- normalize u globally:
  data[{ 2,{},{} }]:add(-mean_u)
  data[{ 2,{},{} }]:div(-std_u)
  -- normalize v globally:
  data[{ 3,{},{} }]:add(-mean_v)
  data[{ 3,{},{} }]:div(-std_v)

data:cuda()

  local result = model:forward(data)
  return result
end

function getTopOnly(sampledata)

imname = string.format('opencv.jpg')

--sampledata=image.load(imname)


 
local result = getRecogResult(sampledata)
local max
local index = 0
  
for k=1,4 do
if max == nil or max < result[k] then
index = k
max = result[k]
--print(max)
end
end
return index
--[=====[ 
--]=====] 
end

nada=0
azul=0
blanca=0
patas=0

for i=1,1000 do
imname = string.format('/home/kenny/Pictures/nuevas_sillas/nuevas_sillas/sillasazul/todas/azul%d.png',i)

I=image.load(imname)

salida=getTopOnly(I)
--print(salida)
if salida==1 then
print(i..' nada')
nada = nada +1
elseif  salida==2 then
print(i..' azul') 
azul = azul+1
elseif  salida==3 then
print(i..' blanca') 
blanca= blanca +1
elseif  salida==4 then
print(i..' patas') 
patas= patas+ 1
else
print('error')
end


end

print('nada '..nada..' azul '..azul..' blanca '..blanca..' patas '..patas)
