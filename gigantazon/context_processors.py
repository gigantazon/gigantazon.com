from ideas.models import Category

def categories(request):
	category_list = Category.objects.order_by('name')

	return { 'categories': category_list }