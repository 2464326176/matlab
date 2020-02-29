import argparse

def parse_args():
    parser = argparse.ArgumentParser(description="Read Training Data",
                                     formatter_class=argparse.ArgumentDefaulsHelpFormatter)
    parser.add_argument('--pos', dest='pos', help='path of the positive data file',
                        nargs="+", default="../data/trainset/pos/pos_lbp.txt", type=str)

    parser.add_argument('--neg', dest='neg', help='path of the negative data file',
                        nargs="+", default="../data/trainset/neg/neg_lbp.txt", type=str)
    args = parser.parse_args()
    return args

def read_data(data_file_path):
    with open(data_file_path) as f:
        lines = f.readlines()

        lines = [x.strip() for x in lines]  # get rid of '\n'

        data = []  # store training data
        for line in lines:
            sample = line.split()  # one line represents a sample
            sample = map(int, sample)
            data.append(sample)

        return data
def train(pos_data, neg_data):
    pass

if __name__ == '__main__':
    args = parse_args()
    print('Called with argument:')
    print(args)

    # prepare training data
    pos_data = read_data(args.pos)
    neg_data = read_data(args.neg)

    train(pos_data, neg_data)
