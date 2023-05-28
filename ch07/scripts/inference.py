import json

from transformers import AutoModelForSequenceClassification
from transformers import Trainer
from transformers import TrainingArguments
from torch.nn import functional as F
from transformers import AutoTokenizer


TOKENIZER = "distilbert-base-uncased-finetuned-sst-2-english"


def selected_model(model_dir):
    return AutoModelForSequenceClassification.from_pretrained(model_dir)
    

def model_fn(model_dir):
    model = selected_model(model_dir=model_dir)
    
    return model


def selected_tokenizer(tokenizer_name):
    return AutoTokenizer.from_pretrained(tokenizer_name)


def predict_fn(input_data, model):    
    statement = input_data['text']
    
    tokenizer = AutoTokenizer.from_pretrained(TOKENIZER)
    
    batch = tokenizer(
        [statement], padding=True, truncation=True, max_length=512, return_tensors="pt"
    )

    output = model(**batch)
    class_a, class_b = F.softmax(output[0][0], dim = 0).tolist()
    
    prediction = "-"
    
    if class_a > class_b:
        prediction = "Negative"

    else:
        prediction = "Positive"
        
    
    return prediction


def input_fn(serialized_input_data, content_type='application/json'):  
    if content_type == 'application/json':
        input_data = json.loads(serialized_input_data)
        
        return input_data
    else:
        raise Exception('Unsupported Content Type')

    
def output_fn(prediction_output, accept='application/json'):
    if accept == 'application/json':
        return json.dumps(prediction_output), accept
    
    raise Exception('Unsupported Content Type')