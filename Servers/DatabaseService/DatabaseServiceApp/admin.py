from django.contrib import admin
from .sql_models import *


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


class GameAdmin(admin.ModelAdmin):
    fieldsets = [
        ('Game', {'fields': ['match_name', 'question_duration']}),
    ]
    #inlines = [ChoiceInline, ChoiceInlineTwo]
    list_display = ('id', 'match_name', 'question_duration',)
    list_filter = ['question_duration']
    search_fields = ['id', 'match_name', 'question_duration']


admin.site.register(Player, PlayerAdmin)
admin.site.register(GameQuestion)
admin.site.register(GamePlayerRound)
admin.site.register(Invite)
admin.site.register(Question)
admin.site.register(Answer)
admin.site.register(Game, GameAdmin)
admin.site.register(GamePlayer)
admin.site.register(GameRound)
