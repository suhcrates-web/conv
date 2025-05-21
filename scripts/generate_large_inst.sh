
### Using GSAI-ML/LLaDA-8B-Instruct  as a backbone, without SFT and RFT

### AlpacaEval
#conv
python gen1_1_answer_generation.py \
init_from_checkpoint.init_file='' \
data.tokenizer_name_or_path=GSAI-ML/LLaDA-8B-Instruct \
backbone=llada_inst \
lora.bool=False \
parameterization=subs \
sampling.steps=128 \
model.length=1024 \
model_max_length=1024 \
sampling.topk_k=20 \
sampling.convolution_kernel_size=512 \
sampling.predictor=ddpm_convolution \
sampling.eos_fill=False \
+category=alpaca_eval_large \
+eval_data=alpaca_eval \
+generator=llada_inst_ddpm_conv_L1024_S128 \
master_port=65535 \
+rand_value=111 \
+batch_size=8

# categorical sampling
python gen1_1_answer_generation.py \
init_from_checkpoint.init_file='' \
data.tokenizer_name_or_path=GSAI-ML/LLaDA-8B-Instruct \
backbone=llada_inst \
lora.bool=False \
parameterization=subs \
sampling.steps=128 \
model.length=1024 \
model_max_length=1024 \
sampling.convolution_kernel_size=512 \
sampling.predictor=ddpm \
sampling.eos_fill=False \
+category=alpaca_eval_large \
+eval_data=alpaca_eval \
+generator=llada_inst_ddpm_L1024_S128 \
master_port=65535 \
+rand_value=111 \
+batch_size=8

# LLADA decoding
python gen1_2_answer_generation_llada.py \
data.tokenizer_name_or_path=GSAI-ML/LLaDA-8B-Instruct \
init_from_checkpoint.init_file='' \
backbone=llada_inst \
lora.bool=False \
sampling.steps=128 \
model.length=1024 \
model_max_length=1024 \
sampling.semi_ar_stride_length=512 \
+category=alpaca_eval_large \
+eval_data=alpaca_eval \
+generator=llada_inst_llada_stride128_L1024_S128 \
master_port=65535 \
+rand_value=111 \
+batch_size=1

# semi-AR 
python gen1_1_answer_generation.py \
init_from_checkpoint.init_file='' \
data.tokenizer_name_or_path=GSAI-ML/LLaDA-8B-Instruct \
backbone=llada_inst \
lora.bool=False \
sampling.steps=128 \
sampling.topk_k=20 \
sampling.semi_ar_stride_length=512 \
sampling.semi_ar_bool=True \
sampling.predictor=ddpm_topk \
+generator=llada_inst_semiar_stride128_L1024_S128 \
+rand_value=112 \
parameterization=subs \
+category=alpaca_eval_large \
+eval_data=alpaca_eval \
master_port=65535 \
+batch_size=8



### gsm8k
python gen1_1_answer_generation.py \
init_from_checkpoint.init_file='' \
data.tokenizer_name_or_path=GSAI-ML/LLaDA-8B-Instruct \
backbone=llada_inst \
lora.bool=False \
parameterization=subs \
sampling.steps=64 \
model.length=512 \
model_max_length=512 \
sampling.topk_k=1 \
sampling.convolution_kernel_size=128\
sampling.predictor=ddpm_convolution \
+category=gsm8k_large \
+eval_data=gsm8k \
+generator=llada_inst_ddpm_conv_L512_S64 \
master_port=65535 \
+rand_value=111 \
+batch_size=8


python gen1_2_answer_generation_llada.py \
data.tokenizer_name_or_path=GSAI-ML/LLaDA-8B-Instruct \
init_from_checkpoint.init_file='' \
backbone=llada_inst \
lora.bool=False \
sampling.steps=64 \
model.length=512 \
model_max_length=512 \
sampling.semi_ar_stride_length=128 \
+rand_value=111 \
+category=gsm8k_large \
+eval_data=gsm8k \
+generator=llada_inst_llada_temp0_stride128_L512_S64 \
master_port=65535 \
+batch_size=1


