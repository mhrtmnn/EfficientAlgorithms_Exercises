H.d = 2;
H.arr = [];
items = [];

item.data = 'Val_4';
item.key = 4;
items = [items, item];
H = dHeap_insert(item, H);

item.data = 'Val_3';
item.key = 3;
items = [items, item];
H = dHeap_insert(item, H);

item.data = 'Val_2';
item.key = 2;
items = [items, item];
H = dHeap_insert(item, H);

item.data = 'Val_1';
item.key = 1;
items = [items, item];
H = dHeap_insert(item, H);

item.data = 'Val_0';
item.key = 0;
items = [items, item];
H = dHeap_insert(item, H);

item.data = 'Val_-1';
item.key = -1;
items = [items, item];
H = dHeap_insert(item, H);

% create a second heap via makeheap and compare both
H2 = dHeap_makeheap(items, 2);

fprintf("\nvia insert\n");
dHeap_printheap(H.arr(1), H);
fprintf("\nvia Makeheap\n");
dHeap_printheap(H2.arr(1), H);

fprintf("\n\n");

H = dHeap_delete(item, H);
H2 = dHeap_delete(item, H2);

fprintf("\nvia insert\n");
dHeap_printheap(H.arr(1), H);
fprintf("\nvia Makeheap\n");
dHeap_printheap(H2.arr(1), H);
