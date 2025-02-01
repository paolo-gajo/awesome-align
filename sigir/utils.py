import pandas as pd
import os

def tsv_to_pharaoh(input_csv_path: str):
    df = pd.read_csv(input_csv_path, sep='\t', names=['src', 'tgt', 'alignments'])
    src_list = df['src'].tolist()
    tgt_list = df['tgt'].tolist()
    
    src_tgt = []
    for src, tgt in zip(src_list, tgt_list):
        src_tgt.append(' '.join([src, '|||', tgt]))
    
    src_tgt_filename = input_csv_path.replace('tsv', 'txt')
    src_tgt_filename = src_tgt_filename.replace('.txt', '.src-tgt')
    par_dir = os.path.dirname(src_tgt_filename)
    if not os.path.exists(par_dir):
        os.makedirs(par_dir)
    with open(src_tgt_filename, 'w', encoding='utf8') as f:
        for line in src_tgt:
            f.write(line + '\n')
    
    align_list = df['alignments'].tolist()
    align_filename = input_csv_path.replace('tsv', 'txt')
    align_filename = align_filename.replace('.txt', '.gold')
    with open(align_filename, 'w', encoding='utf8') as f:
        for line in align_list:
            f.write(line + '\n')

def main():
    path = './data/XL-WA/tsv/'
    for root, dirs, files in os.walk(path):
        for F in files:
            filename = os.path.join(root, F)
            if filename.endswith('.tsv'):
                tsv_to_pharaoh(filename)

if __name__ == "__main__":
    main()
