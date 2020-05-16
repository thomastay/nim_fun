import itertools
MAX_ELT = 70

## Yields the two nonconsecutive elts
## Then the position of the consecutive element
def positions():
    yield (0, 1, 2)
    yield (3, 4, 0)
    yield (0, 4, 1)


def tup():
    sequence = [0,0,0,0,0]
    for (nc_1, nc_2, c) in positions():
        for conseq in range(1, MAX_ELT - 1):
            sequence[(c + 0) % 5] = conseq
            sequence[(c + 1) % 5] = conseq + 1
            sequence[(c + 2) % 5] = conseq + 2
            for non_conseq_1, non_conseq_2 in itertools.product(
                range(1, MAX_ELT + 1), range(1, MAX_ELT +1)):
                sequence[nc_1] = non_conseq_1
                sequence[nc_2] = non_conseq_2
                yield sequence

def num_unique_tuples():
    return len({tuple(s) for s in tup()})

if __name__ == "__main__":
    print(num_unique_tuples())
