function flow = get_optical_flow(i, j, flows_a)
    if (i > j)
        k = (i-1) * (i-2) / 2 + j;
        flow = flows_a(:,:,:,k);
    else
        k= (j-1) * (j-2) / 2 + i;
        flow = -flows_a(:,:,:,k');
    end
end