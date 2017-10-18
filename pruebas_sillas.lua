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
require 'cunn'
require 'nnx'
require 'dok'
require 'image'
require 'cudnn'
require 'torch'   -- torch
require 'xlua'    -- xlua provides useful tools, like progress bars
require 'optim'   -- an optimization package, for online and batch methods

----------------------------------------------------------------------
-- set options

-- fix seed
torch.manualSeed(1)
-- set number of threads
torch.setnumthreads(8)
--torch.setdefaulttensortype('torch.DoubleTensor')
--torch.setdefaulttensortype('torch.FloatTensor')
-- classname for cifar 10
classes={'nada','azul','blanca' ,'patas'}

print('load pretrained network file')

model=torch.load('model.net')


--cudnn.convert(network, nn)
--model= network:float()
--model:evaluate()
--torch.save('sillas_float.bin', model)
print '==> here is the model:'
print(model)
model:cuda()
--model=torch.load('sillas_float.bin')
--model= network:cuda()

   --model:evaluate()
--model=torch.load('model.net')
--torch.save('cifar.net.ascii', model, 'ascii')


--model=torch.load('cifar.net.ascii', 'ascii')
--torch.save('cifar.net.bi', model, 'binary')
--model=torch.load('cifar.net.bi')


--parameters,gradParameters = model:getParameters()

--model:add(nn.LogSoftMax())
criterion = nn.ClassNLLCriterion()
criterion:cuda()
-- read mean & std values
mean_y=torch.load('mean_y_sillas')
mean_u=torch.load('mean_u_sillas')
mean_v=torch.load('mean_v_sillas')

std_y=torch.load('std_y_sillas')
std_u=torch.load('std_u_sillas')
std_v=torch.load('std_v_sillas')

--[[
print('mean_y ' .. mean_y)
print('mean_u ' .. mean_u)
print('mean_v ' .. mean_v)

print('std_y ' .. std_y)
print('std_u ' .. std_u)
print('std_v ' .. std_v)

]]--
--model:add(nn.SoftMax())
-- function for test image
function getRecogResult(sampledata)
   model:evaluate()

  data = sampledata--:reshape(3,32,32)

 -- data = torch.DoubleTensor():set(sampledata)

data=data:float()
image.saveJPG('entrada0.jpg',data)
--data=sampledata:cuda()
neighborhood = image.gaussian1D(13)
  normalization = nn.SpatialContrastiveNormalization(1, neighborhood, 1):float()


--[[
  local rgb = data

  local yuv = image.rgb2yuv(rgb)



  -- print 'normalize y locally'
  yuv[1] = normalization(yuv[{{1}}])
  data = yuv

]]--
channels = {'y','u','v'}

  local foto = image.rgb2yuv(data)

 
  foto[{ 1,{},{} }]:add(-mean_y)
  foto[{ 1,{},{} }]:div(std_y)

  foto[{ 2,{},{} }]:add(-mean_u)
  foto[{ 2,{},{} }]:div(std_u)

  foto[{ 3,{},{} }]:add(-mean_v)
  foto[{ 3,{},{} }]:div(std_v)


for c in ipairs(channels) do

      foto[{ {c},{},{} }] = normalization:forward(foto[{{c},{},{} }])

end




foto=foto:cuda()
image.saveJPG('entarada1.jpg',foto)

  local result = model:forward(foto)
  return result
end

function getTopOnly(sampledata)


imname = string.format('opencv.jpg')
sampledata=image.load(imname)


 
local result = getRecogResult(sampledata)
local max
local index = 0
  
for k=1,4 do
if max == nil or max < result[k] then
index = k
max = result[k]

end

end
return index
end
