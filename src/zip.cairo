use array::ArrayTrait;
use debug::PrintTrait;
#[derive(Copy, Drop)]
fn compressed_data(input:Array<felt252>) -> Array<felt252> {
    let mut count = 0;
    let mut i: usize = 0;
    let mut compressed_data = ArrayTrait::new();
    loop {
        if *input.at(i) == *input.at(i+1) {
            count += 1;
            i += 1;
        } else {
            count += 1;
            compressed_data.append(count);
            compressed_data.append(*input.at(i));
            count = 0;
            i += 1;
        };
        if i==input.len()-1 {
            count += 1;
            compressed_data.append(count);
            compressed_data.append(*input.at(i));
            i += 1;
        }
        if i > input.len()-1 {
            break;
        };
    };
    return compressed_data;
}

fn decompressed_data(compressed_input:Array<felt252>) -> Array<felt252> {
    let mut count = 0;
    let mut i: usize = 0;
    let mut decompressed_data = ArrayTrait::new();
    let first_snapshot = @compressed_input;
    loop {
        if i > first_snapshot.len()-2 {
            break;
        };
        count = *first_snapshot.at(i);
        loop {
            if count == 0 {
                break;
            };
            decompressed_data.append(*first_snapshot.at(i+1));
            count -= 1;
        };
        i+=2;

    };
    return decompressed_data;
}

fn main() {
    let mut input = ArrayTrait::<felt252>::new();
    input.append(10);
    input.append(10);
    input.append(10);
    input.append(1);
    input.append(1);
    input.append(5);
    input.append(5);
    input.append(5);
    input.append(2);
    compressed_data(input).print();
    // let comp = compressed_data(input);
    // decompressed_data(comp).print();
}