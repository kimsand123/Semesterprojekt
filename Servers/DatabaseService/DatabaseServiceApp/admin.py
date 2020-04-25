from django.contrib import admin
from .models import *


class ChoiceInline(admin.TabularInline):
    model = Question
    extra = 3


class ChoiceInlineTwo(admin.TabularInline):
    model = GamePlayerRound
    extra = 3


class PlayerAdmin(admin.ModelAdmin):
    fieldsets = [
        ('Identifiers', {'fields': ['username', ]}),
        ('Personal info', {'fields': ['first_name', 'last_name', ]}),
        ('Contact info', {'fields': ['email', ]}),
        ('Misc', {'fields': ['study_programme', 'high_score']}),
    ]
    list_display = ('id', 'username', 'first_name', 'last_name', 'email', 'study_programme', 'high_score')
    list_filter = ['study_programme']
    search_fields = ['campus_id', 'first_name', 'last_name', 'email', 'study_programme', 'high_score']


admin.site.register(Player, PlayerAdmin)
admin.site.register(GameQuestion)
admin.site.register(GamePlayerRound)
admin.site.register(Invite)
admin.site.register(Question)
admin.site.register(Game)
admin.site.register(GamePlayer)
admin.site.register(GameRound)
