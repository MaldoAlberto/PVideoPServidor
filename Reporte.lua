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
--require 'cudnn'
require 'torch'   -- torch
require 'xlua'    -- xlua provides useful tools, like progress bars
require 'optim'   -- an optimization package, for online and batch methods
require 'gnuplot'
----------------------------------------------------------------------
-- set options
local Timestamp = os.time()
local TimeString = os.date("%H:%M:%S_%d-%m-%Y", Timestamp )
print( "Timestamp:", Timestamp )
print( "TimeString:", TimeString )
local fecha = os.date("%H:%M:%S %d-%m-%Y", Timestamp )
-- fix seed

tam_frames = 10
epoca = 12
caricaturaP = 0
futbolP = 0
documentalP = 0
guerraP = 0
noticiaP = 0
novelaP = 0
i=1


-- test
local testFile = io.open('datos.txt', 'r')  
local header = testFile:read()
local dataTest = torch.Tensor(epoca, 1)

local i = 0  
for line in testFile:lines('*l') do  
  i = i + 1
  local l = line:split(',')
  for key, val in ipairs(l) do
    dataTest[i][key] = val
  end
end

testFile:close()  
gnuplot.pdffigure('Reporte '.. TimeString ..'.pdf')
gnuplot.plot({'Epocas de prueba',dataTest})
gnuplot.raw('set xtics ("Caricatura" 1, "Futbol" 2,"Documental" 3, "Guerra" 4, "Noticia" 5, "Novela" 6)')
gnuplot.plotflush()
gnuplot.axis{0,6,0,''}
gnuplot.grid(true)
gnuplot.title('Reporte de la clasificación en us sesion ' .. fecha)
gnuplot.xlabel('generos')
gnuplot.ylabel('muestras del servidor ')
gnuplot.plotflush()
gnuplot.close()



	
